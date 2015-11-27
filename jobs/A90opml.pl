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
#JOB_DESCRIPTION: Update feeds opml file: news.opml

use strict;
use warnings;
use MyPlace::String::Utils qw/strtime/;
my $TOPDIR = shift(@ARGV) || "";

print STDERR "\n",strtime(),": Close file news.opml and update\n";
open FO,'>>',$TOPDIR . 'news.opml';
print FO <<EOB
	</outline>
	</body>
	</opml>
EOB
;
close FO;
exit system($TOPDIR . "bin/" . "git_update",$TOPDIR,$TOPDIR . "news.opml");

