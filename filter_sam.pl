#!/usr/bin/perl
# FILE_NAME.pl
# Mike Covington
# created: 2012-04-10
#
# Description: 
#
use strict; use warnings;



# IF YOU WANT TO INCREASE THROUGHPUT, USE SOMETHING LIKE THIS:
# my $input = $ARGV[0];
# 
# my @input_files = `ls $input`;
# 
# foreach my $sam (@input_files) {
# 	#do everything
# }

open SAM_IN, '<', "test2.sam";
open OUT, '>', "test.out.sam";

my $pe1_raw = <SAM_IN>;

while ($pe1_raw =~ m/^@/) { #read in SAM file until header is gone
	$pe1_raw = <SAM_IN>;
}

while (my $pe2_raw = <SAM_IN>) {
	my ($read_1, $flag_1, $chr_1) = split(/\t/, $pe1_raw);
	my ($read_2, $flag_2, $chr_2) = split(/\t/, $pe2_raw);
	
	next unless substr ($read_1, -1) =~ m/0/;
	next unless substr ($read_2, -1) =~ m/[23]/;
	
	if ($chr_1 eq $chr_2) {
		print OUT $pe1_raw, $pe2_raw;
		$pe2_raw = <SAM_IN>;
	}
} continue {
	$pe1_raw = $pe2_raw;
}

close(SAM_IN);
close(OUT);
exit;