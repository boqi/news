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
use utf8;
use File::Glob qw/bsd_glob/;
use MyPlace::String::Utils qw/strtime/;
our $VERSION = 'v0.1';
my @OPTIONS = qw/
	help|h|? 
	manual|man
	title|t=s
	description|desc|d=s
	generator|gen|g=s
	author|a=s
	verbose|v
	topdir|tdir|dir=s
	sleepwait|timewait|sleep|wait=i
/;
my %OPTS;
if(@ARGV)
{
    require Getopt::Long;
    Getopt::Long::GetOptions(\%OPTS,@OPTIONS);
}
else {
	$OPTS{'help'} = 1;
}
if($OPTS{'help'} or $OPTS{'manual'}) {
	require Pod::Usage;
	my $v = $OPTS{'help'} ? 1 : 2;
	Pod::Usage::pod2usage(-exitval=>$v,-verbose=>$v);
    exit $v;
}


my $TOPDIR = $OPTS{topdir} || shift(@ARGV) || '';
$TOPDIR =~ s/\/+$//;
if(!$TOPDIR) {
	$TOPDIR = "";
}
elsif($TOPDIR eq '.') {
	$TOPDIR = '';
}
else {
	$TOPDIR = $TOPDIR . '/';
}
my $TIMEWAIT = $OPTS{sleepwait} || 3;
my $JOBSEL = shift(@ARGV) || 'A';


my $done =0;
my $failed = 0;
foreach my $idx(map("0$_",(1..9)),(10 .. 99)) {
	foreach my $job(&bsd_glob("${TOPDIR}jobs/$JOBSEL$idx*.pl")) {
		my $description = "";
		if(open FI,'<',$job) {
			foreach(<FI>) {
				chomp;
				if(m/^\s*#?\s*JOB_DESCRIPTION:\s*(.+)$/){
					$description = $1;
					last;
				}
			}
			close FI;
		}
		print STDERR "\n",strtime(),": [$job] $description\n";
		if(system("perl","-w","--",$job,$TOPDIR)==0) {
			print STDERR "\n",strtime(),": [$job] Succeeded\n";
			$done++;
		}
		else {
			print STDERR "\n",strtime(),": [$job] Failed\n";
			$failed++;
		}
		if($description) {
			print STDERR "\n",strtime(),": Push to repository\n";
			system("git","commit","-am","[$job] $description");
			system("git","push","origin","master");
		}
		sleep $TIMEWAIT;
	}
}

my $status = "$done jobs done, $failed failed";
print STDERR "\n",strtime(),": $status\n";
print STDERR "\n","Push to repository\n";
system("git","commit","-am",$status);
system("git","push","origin","master");

exit 0;

