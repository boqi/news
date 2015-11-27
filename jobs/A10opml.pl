#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: update.pl
#
#        USAGE: ./update.pl  
#
#  DESCRIPTION: 
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 2015/11/22  3:53:24
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use MyPlace::String::Utils qw/strtime/;
my $TOPDIR = shift(@ARGV) || "";
my $OUTDIR = shift(@ARGV) || "";

print STDERR "\n",strtime(),": Rewritting file news.opml head\n";
open FO,'>',$OUTDIR . 'news.opml';
print FO <<EOB
	<?xml version="1.0" encoding="UTF-8"?>
	<opml version="1.0">
		<head>
			<title>Boqi local news</title>
	    </head>
	<body>
	<outline text="BOQIRSS" title="BOQIRSS">
EOB
;
close FO;

exit 0;
