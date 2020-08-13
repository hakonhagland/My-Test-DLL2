use 5.030000;
use strict;
use warnings;
use utf8;
use ExtUtils::MakeMaker 7.12; # for XSMULTI option
use File::Spec;

{
    my $gsl_config = get_gsl_config();
    my $gsl_cflags = qx($gsl_config --cflags);
    my $gsl_libs = qx($gsl_config --libs);
    WriteMakefile(
        NAME          => 'My::Test::DLL2',
        VERSION_FROM  => 'lib/My/Test/DLL2.pm',
        PREREQ_PM     => { 'ExtUtils::MakeMaker' => '7.12' },
        ABSTRACT_FROM => 'lib/My/Test/DLL2.pm',
        AUTHOR        => 'Håkon Hægland <hakon.hagland@gmail.com>',
        OPTIMIZE      => '',  # e.g., -O3 (for optimize), -g (for debugging)
        XSMULTI       => 0,
        LICENSE       => 'perl',
        LIBS          => ["$gsl_libs"], # e.g., '-lm'
        DEFINE        => '', # e.g., '-DHAVE_SOMETHING'
        INC           => "$gsl_cflags", # e.g., '-I. -I/usr/include/other'
    );
}

sub get_gsl_config {
    my $gsl_config = "gsl-config";
    my $res = system $gsl_config, "--version";
    if ( $res != 0) {
        say "gsl-config not found in PATH..";
        if ($ENV{GSL_PATH}) {
            $gsl_config = File::Spec->catfile($ENV{GSL_CONFIG_PATH}, $gsl_config);
            say "checking GSL_PATH, .. ok.";
            say "trying $gsl_config..";
            my $res = system $gsl_config, "--version";
            if ( $res != 0) {
                die "Could not find gsl-config\n";
            }
        }
        else {
            say "Could not find gsl-config, try setting environment variable "
              . "GSL_PATH to its installation directory, and rerun perl Makefile.PL";
            die "Abort.\n";
        }
    }
    return $gsl_config;
}
