package Slic3r::Print::Object;
# extends c++ class Slic3r::PrintObject (Print.xsp)
use strict;
use warnings;

use POSIX;
use List::Util qw(min max sum first any);
use Slic3r::Flow ':roles';
use Slic3r::Geometry qw(X Y Z PI scale unscale chained_path epsilon);
use Slic3r::Geometry::Clipper qw(diff diff_ex intersection intersection_ex union union_ex 
    offset offset_ex offset2 offset2_ex intersection_ppl CLIPPER_OFFSET_SCALE JT_MITER);
use Slic3r::Print::State ':steps';
use Slic3r::Surface ':types';


sub region_volumes {
    my $self = shift;
    return [ map $self->get_region_volumes($_), 0..($self->region_count - 1) ];
}

sub layers {
    my $self = shift;
    return [ map $self->get_layer($_), 0..($self->layer_count - 1) ];
}

sub support_layers {
    my $self = shift;
    return [ map $self->get_support_layer($_), 0..($self->support_layer_count - 1) ];
}

sub generate_support_material {
    my $self = shift;
    
    return if $self->step_done(STEP_SUPPORTMATERIAL);
    $self->print->status_cb->(85, "Generating support material")
        if $self->config->support_material || $self->config->raft_layers > 0
            || $self->config->support_material_enforce_layers > 0;
    
    # the C++ support generation (slices first; the Perl port was removed)
    $self->_generate_support_material;
    
    if ($self->support_layer_count > 0) {
        my $stats = sprintf "Weight: %.1fg, Cost: %.1f" , $self->print->total_weight, $self->print->total_cost;
        $self->print->status_cb->(85, $stats);
    }
}

1;
