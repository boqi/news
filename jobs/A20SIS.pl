#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: A20SIS.pl
#
#        USAGE: ./A20SIS.pl  
#
#  DESCRIPTION: Update rss feeds for SIS
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 2015/11/25  0:29:05
#     REVISION: ---
#===============================================================================
#JOB_DESCRIPTION: Update rss feeds for SIS

use strict;
use warnings;


my $SIS = 'http://67.220.90.4/bbs/forum-',
my @SIS_FORUM = (
	['110','SIS转帖乱伦人妻'],
	['406','SIS磁链'],
#	['143','SIS亚洲无码原创'],
	['230','SIS亚洲有码原创'],
	['229','SIS欧美无码原创'],
	['231','SIS卡通漫画原创'],
	['341','SIS亚洲小WMV'],
	['20','SIS亚洲小格式'],
	['25','SIS亚洲大格式'],
	['58','SIS亚有码薄码'],
	['77','SIS欧美无码'],
	['345','SIS欧美小格式'],
	['27','SISH游戏卡通漫画'],
	['122','SIS自助推荐压缩'],
	['318','SIS第六天魔王'],
	['200','SIS成人卡通'],
);
my @REQUEST;
foreach my $id(@SIS_FORUM){
	push @REQUEST,[
		$id->[0],
		$id->[1],
		'sis' . $id->[0],
		$SIS . $id->[0] . '-1.html',
		$SIS . $id->[0] . '-1.html',
	];
}

my $TOPDIR = shift(@ARGV) || '';
open FO,'|-',$TOPDIR . 'bin/' . 'generate_rss',$TOPDIR or die("$!\n");
foreach(@REQUEST) {
	print FO join("\t",@$_),"\n";
}
close FO;

exit 0;


