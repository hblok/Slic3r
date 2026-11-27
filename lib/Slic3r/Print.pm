# The slicing work horse.
# Extends C++ class Slic3r::Print
package Slic3r::Print;
use strict;
use warnings;

use File::Basename qw(basename fileparse);
use File::Spec;
use List::Util qw(min max first sum);
use Slic3r::ExtrusionLoop ':roles';
use Slic3r::ExtrusionPath ':roles';
use Slic3r::Flow ':roles';
use Slic3r::Geometry qw(X Y Z X1 Y1 X2 Y2 MIN MAX PI scale unscale convex_hull);
use Slic3r::Geometry::Clipper qw(diff_ex union_ex intersection_ex intersection offset
    offset2 union union_pt_chained JT_ROUND JT_SQUARE diff_pl);
use Slic3r::Print::State ':steps';
use Slic3r::Surface qw(S_TYPE_BOTTOM);

our $status_cb;

sub set_status_cb {
    my ($class, $cb) = @_;
    $status_cb = $cb;
}

sub status_cb {
    return $status_cb // sub {};
}

# this value is not supposed to be compared with $layer->id
# since they have different semantics
sub total_layer_count {
    my $self = shift;
    return max(map $_->total_layer_count, @{$self->objects});
}

sub size {
    my $self = shift;
    return $self->bounding_box->size;
}

sub process {
    my ($self) = @_;
    
    ### No need to call this as we call it as part of prepare_infill()
    ### until we fix the idempotency issue.
    ###$self->status_cb->(20, "Generating perimeters");
    ###$_->make_perimeters for @{$self->objects};
    
    $self->status_cb->(70, "Infilling layers");
    $_->infill for @{$self->objects};
    
    $_->generate_support_material for @{$self->objects};
    $self->make_skirt;
    $self->make_brim;  # must come after make_skirt
}

sub export_gcode {
    my $self = shift;
    my %params = @_;
    
    # prerequisites
    $self->process;
    
    if ($params{output_fh}) {
        # the C++ G-code export (PrintGCode) as one string, UTF-8 bytes
        print {$params{output_fh}} $self->_export_gcode;
        return;
    }
    
    my $output_file = $self->output_filepath($params{output_file} // '');
    $self->status_cb->(90, "Exporting G-code" . ($output_file ? " to $output_file" : ""));
    $self->status_cb->(95, "Running post-processing scripts") if @{$self->config->post_process};
    # C++: temporary file and rename, then the post-processing scripts (no shell)
    $self->_export_gcode_file($params{output_file} // '');
}

# Export SVG slices for the offline SLA printing (written by the C++ Print::export_svg).
sub export_svg {
    my $self = shift;
    my %params = @_;
    
    my $fh = $params{output_fh};
    if (!$fh) {
        my $output_file = $self->output_filepath($params{output_file} // '');
        $output_file =~ s/\.gcode$/.svg/i;
        Slic3r::open(\$fh, ">", $output_file) or die "Failed to open $output_file for writing\n";
        binmode $fh;
        print "Exporting to $output_file..." unless $params{quiet};
    }
    print $fh $self->_export_svg;
    close $fh unless $params{output_fh};
    print "Done.\n" unless $params{quiet};
}

sub make_brim {
    my $self = shift;
    
    # prerequisites
    $_->make_perimeters for @{$self->objects};
    $_->infill for @{$self->objects};
    $_->generate_support_material for @{$self->objects};
    $self->make_skirt;
    
    $self->status_cb->(88, "Generating brim");
    $self->_make_brim;
}

# Wrapper around the C++ Slic3r::Print::validate()
# to produce a Perl exception without a hang-up on some Strawberry perls.
sub validate
{
    my $self = shift;
    my $err = $self->_validate;
    die $err . "\n" if (defined($err) && $err ne '');
}

1;
