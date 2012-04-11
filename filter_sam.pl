#!/usr/bin/perl
use strict;
use warnings;

open (pe1_raw, ">test.sam");

while (my $pe2_raw = ">test.sam") {
	chomp;
	my($Read,$Flag,$Chr,$POS,$MAPQ,$CIGAR,$RNEXT,$PNEXT,$ISIZE,$SEQ,$QUAL,$TAG1) = split("/t");
	next unless substr($pe1_raw($Read,31)) = ~m/0/i;
	next unless substr($pe2_raw($Read,31)) = ~m/[23]/i;
	if ($pe1_raw eq $pe2_raw) {
		print OUT $pe1_raw, $pe2_raw;
		$pe2_raw = "<output.sam";
	}
} continue {$pe1_raw=$pe2_raw}

close();
exit;

