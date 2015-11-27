#!/usr/bin/perl -w
#JOB_DESCRIPTION: DEBUG ONLY, WATCH OUT
use strict;
use MyPlace::Debug::Dump;

my $idx=-1;
foreach(@ARGV) {
	$idx++;
	print STDERR &debug_dump($ARGV[$idx],"ARGV[$idx]"),"\n";
}

exit 0;
