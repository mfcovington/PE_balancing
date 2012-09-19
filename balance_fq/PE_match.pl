#!/usr/bin/env perl
# FILE_NAME.pl
# Mike Covington
# created: 2011-09-07
#
# Description: Extracts matching sequences from PE .fq files where some sequences have been removed
#

use strict;
use warnings;
use Getopt::Long;
use File::Basename;
use autodie;

my $pe1_in = "PE1 file";
my $pe2_in = "PE2 file";
my $help;

my $input = GetOptions(
    "pe1=s" => \$pe1_in,
    "pe2=s" => \$pe2_in,
    "help"  => \$help
);

if ($help){
    print "\n\nUsage: perl PE_match.pl --pe1 PE1_input_filename.fq --pe2 PE2_input_filename.fq\n\n";
    exit;
}

my ( $pe1_file, $pe1_dir ) = fileparse( $pe1_in, ".f(ast)q" );
my ( $pe2_file, $pe2_dir ) = fileparse( $pe2_in, ".f(ast)q" );
my $pe1_out = $pe1_dir . $pe1_file . "_matched.fq";
my $pe2_out = $pe2_dir . $pe2_file . "_matched.fq";

my $l1;
my $l2;
my $l3;
my $l4;
my %name1;
my %name2;

open my $pe1_in_fh, "<", $pe1_in;
while ( $l1 = <$pe1_in_fh> ) {
    $l2 = <$pe1_in_fh>;
    $l3 = <$pe1_in_fh>;
    $l4 = <$pe1_in_fh>;
    my @seq_name = split( /\s/, $l1 );
    $name1{ $seq_name[0] } = 1;
}
close($pe1_in_fh);

open my $pe2_in_fh,   "<", $pe2_in;
open my $pe2_out_fh,  ">", $pe2_out;
while ( $l1 = <$pe2_in_fh> ) {
    $l2 = <$pe2_in_fh>;
    $l3 = <$pe2_in_fh>;
    $l4 = <$pe2_in_fh>;
    my @seq_name = split( /\s/, $l1 );
    if ( $name1{ $seq_name[0] } ) {
        print $pe2_out_fh $l1, $l2, $l3, $l4;
        $name2{ $seq_name[0] } = 1;
    }
}
close($pe2_in_fh);
close($pe2_out_fh);

open my $pe1_in_fh, "<", $pe1_in;
open my $pe1_out_fh,  ">", $pe1_out;
while ( $l1 = <$pe1_in_fh> ) {
    $l2 = <$pe1_in_fh>;
    $l3 = <$pe1_in_fh>;
    $l4 = <$pe1_in_fh>;
    my @seq_name = split( /\s/, $l1 );
    if ( $name2{ $seq_name[0] } ) {
        print $pe1_out_fh $l1, $l2, $l3, $l4;
    }
}
close($pe1_in_fh);
close($pe1_out_fh);

