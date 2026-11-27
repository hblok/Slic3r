#!/usr/bin/env perl

use strict;
use warnings;

BEGIN {
    use FindBin;
    use lib "$FindBin::Bin/lib";
    # only for a bundled local-lib/ (none in utils/make_dist.sh's run directory)
    if (-d "$FindBin::Bin/local-lib") {
        require local::lib;
        local::lib->import('--no-create', "$FindBin::Bin/local-lib");
    }
}

use Getopt::Long qw(:config no_auto_abbrev);
use POSIX qw(setlocale LC_NUMERIC);
use Slic3r;
$|++;
binmode STDOUT, ':utf8';
binmode STDERR, ':utf8';
$ENV{GDK_BACKEND} = 'x11';

our %opt = ();
my %cli_options = ();
my @original_argv = @ARGV;  # handed to the C++ command line
{
    my %options = (
        'help'                  => sub { usage() },
        'version'               => sub { print "$Slic3r::VERSION\n"; exit 0 },
        
        'debug'                 => \$Slic3r::debug,
        'gui'                   => \$opt{gui},
        'no-gui'                => \$opt{no_gui},
        'o|output=s'            => \$opt{output},
        'j|threads=i'           => \$opt{threads},
        
        'save=s'                => \$opt{save},
        'load=s@'               => \$opt{load},
        'autosave=s'            => \$opt{autosave},
        'ignore-nonexistent-config' => \$opt{ignore_nonexistent_config},
        'datadir=s'             => \$opt{datadir},
        'export-svg'            => \$opt{export_svg},
        'merge|m'               => \$opt{merge},
        'repair'                => \$opt{repair},
        'cut=f'                 => \$opt{cut},
        'cut-grid=s'            => \$opt{cut_grid},
        'split'                 => \$opt{split},
        'info'                  => \$opt{info},
        
        'scale=f'               => \$opt{scale},
        'rotate=f'              => \$opt{rotate},
        'rotate-x=f'            => \$opt{rotate_x},
        'rotate-y=f'            => \$opt{rotate_y},
        'duplicate=i'           => \$opt{duplicate},
        'duplicate-grid=s'      => \$opt{duplicate_grid},
        'print-center=s'        => \$opt{print_center},
        'dont-arrange'          => \$opt{dont_arrange},
        
        # legacy options, ignored
        'no-plater'             => \$opt{no_plater},
        'gui-mode=s'            => \$opt{gui_mode},
    );
    # Names already taken: a config option must not redefine them (Getopt::Long warns
    # and picks a winner in hash order, e.g. for --threads).
    my %taken = map { $_ => 1 } map { split /\|/, s/[=:!+].*//r } keys %options;
    foreach my $opt_key (sort keys %{$Slic3r::Config::Options}) {
        my $cli = $Slic3r::Config::Options->{$opt_key}->{cli} or next;
        my ($names, $type) = $cli =~ /^([^=:!+]*)(.*)$/;
        # allow both the dash-separated option name and the full opt_key
        my %seen;
        my @names = grep { !$taken{$_} && !$seen{$_}++ } $opt_key, split /\|/, $names;
        next if !@names;
        $taken{$_} = 1 for @names;
        $options{ join('|', @names) . $type } = \$cli_options{$opt_key};
    }
    
    @ARGV = grep !/^-psn_\d/, @ARGV if $^O eq 'darwin';
    GetOptions(%options) or usage(1);
    
    warn "--no-plater option is deprecated; ignoring\n" if $opt{no_plater};
    warn "--gui-mode option is deprecated (Slic3r now has only Expert Mode); ignoring\n"  if $opt{gui_mode};
}

# load configuration files
my @external_configs = ();
if ($opt{load}) {
    foreach my $configfile (@{$opt{load}}) {
        $configfile = Slic3r::decode_path($configfile);
        if (-e Slic3r::encode_path($configfile)) {
            push @external_configs, Slic3r::Config->load($configfile);
        } elsif (-e Slic3r::encode_path("$FindBin::Bin/$configfile")) {
            printf STDERR "Loading $FindBin::Bin/$configfile\n";
            push @external_configs, Slic3r::Config->load("$FindBin::Bin/$configfile");
        } else {
            $opt{ignore_nonexistent_config} or die "Cannot find specified configuration file ($configfile).\n";
        }
    }
    
    # expand shortcuts before applying, otherwise destination values would be already filled with defaults
    $_->normalize for @external_configs;
}

# process command line options
my $cli_config = Slic3r::Config->new_from_cli(%cli_options);
$cli_config->normalize;  # expand shortcuts

# save configuration
if ($opt{save}) {
    my $config = $cli_config->clone;
    $config->apply($_) for @external_configs;
    if (@{$config->get_keys} > 0) {
        $config->save($opt{save});
    } else {
        Slic3r::Config->new_from_defaults->save(Slic3r::decode_path($opt{save}));
    }
}

# launch GUI
my $gui;
if ((!@ARGV || $opt{gui}) && !$opt{no_gui} && !$opt{save} && eval "require Slic3r::GUI; 1") {
    {
        no warnings 'once';
        $Slic3r::GUI::datadir       = Slic3r::decode_path($opt{datadir} // '');
        $Slic3r::GUI::autosave      = Slic3r::decode_path($opt{autosave} // '');
        $Slic3r::GUI::threads       = $opt{threads};
    }
    $gui = Slic3r::GUI->new;
    setlocale(LC_NUMERIC, 'C');
    $gui->CallAfter(sub {
        $gui->{mainframe}->load_config_file($_) for @{$opt{load}};
        $gui->{mainframe}->load_config($cli_config);
        foreach my $input_file (@ARGV) {
            $input_file = Slic3r::decode_path($input_file);
            $gui->{mainframe}{plater}->load_file($input_file);
        }
    });
    $gui->MainLoop;
    exit;
}
die $@ if $@ && $opt{gui} && !$opt{no_gui};

# Command line: the C++ CLI does the work (the Perl command line was retired
# 2026-11-27). Same options, except --print-center (C++: --center) and -j (--threads);
# Perl sliced when no other action was given, C++ needs -g for that.
if (@ARGV) {
    my $cli = cpp_cli() // die "The C++ command line program was not found: build it "
        . "(cmake --build build) or use the run directory from utils/make_dist.sh.\n";
    my @args = ();
    my @in = @original_argv;
    while (@in) {
        my $arg = shift @in;
        # saved above, GUI only, or legacy
        if ($arg =~ /^--(?:save|datadir|autosave|gui-mode)$/) { shift @in; next }
        next if $arg =~ /^--(?:save|datadir|autosave|gui-mode)=/ || $arg =~ /^--(?:no-gui|gui|no-plater|debug)$/;
        $arg =~ s/^--print-center\b/--center/;
        $arg = '--threads' if $arg eq '-j';
        push @args, $arg;
    }
    push @args, '--export-gcode'
        if !grep /^(?:-g|--gcode|--export-[\w-]+|--sla|--repair|--split|--cut(?:-grid)?(?:=.*)?|--info)$/, @args;
    exec { $cli } $cli, @args or die "Cannot run $cli: $!\n";
} else {
    usage(1) unless $opt{save};
}

# the C++ command line program: next to slic3r.pl in a run directory, else in build/
sub cpp_cli {
    for my $file ("$FindBin::Bin/slic3r-cli", "$FindBin::Bin/build/slic3r") {
        return $file if -f $file && -x $file;
    }
    return undef;
}

sub usage {
    my ($exit_code) = @_;
    
    print <<"EOF";
Slic3r $Slic3r::VERSION is a STL-to-GCODE translator for RepRap 3D printers
written by Alessandro Ranellucci <aar\@cpan.org> - https://slic3r.org/

Usage: slic3r.pl [ OPTIONS ] [ file.stl ] [ file2.stl ] ...

Without files, or with --gui, this starts the GUI:
    --gui               Start the GUI and load the given files into the plater
    --no-gui            Never start the GUI
    --load <file>       Load configuration from the specified file (repeatable)
    --datadir <path>    Load and store settings at the given directory
    --autosave <file>   Automatically export current configuration to the specified file
    --save <file>       Save configuration to the specified file
    -j, --threads <num> Number of threads to use
    --version           Output the version of Slic3r and exit

With files, the C++ command line program does the work (G-code unless another action
is given; --print-center is --center there). Its options:

EOF
    if (my $cli = cpp_cli()) {
        system $cli, '--help';
    } else {
        print "    (not found: build it with cmake, see README)\n";
    }
    exit ($exit_code || 0);
}

__END__
