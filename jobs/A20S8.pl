#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: A20S8.pl
#
#        USAGE: ./A20S8.pl  
#
#  DESCRIPTION: Update rss feeds for S8
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
#JOB_DESCRIPTION: Update rss feeds for S8

use strict;
use warnings;


my $S8 = 'http://segirlsong.com/thread-htm-fid-';#155.html';
my @S8_FORUM = (qw/
	400 S8日更节目
	100 S8有声小说
	148	S8聊天活动室
-NEEDLOGIN	142 S8另类视频
-NEEDLOGIN	181 S8网友自拍
-NEEDLOGIN	180 S8经典三级
-NEEDLOGIN	307 S8亚洲无码
-NEEDLOGIN	27 S8欧美性爱
-NEEDLOGIN	222 S8亚洲有码
-NEEDLOGIN	289 S8卡通动漫
	427 S8下载新帖发布
	96 S8亚洲无码下载
	134 S8亚洲有码下载
	135 S8欧美下载
	136 S8动漫影视下载
	280 S8性吧影视精品（小格式）
	232 S8特邀嘉宾新片
	233 S8第六天魔王
	103 S8网盘下载
-NEEDLOGIN	71 S8转贴精品
	106 S8另类同人
-NEEDLOGIN	147 S8图片合成
	11 S8亚洲性爱
	12 S8欧美性爱
	149 S8亚洲裸女
	150 S8欧美裸女
	225 S8裸模艺术
	434 S8官方套图
	3 S8亚欧动漫套图
	253 S8国模套图
	157 S8生活自拍
	158 S8性爱自拍
	159 S8街拍
	155 S8极致诱惑
	65 S8明星
	20 S8动漫
	267 S8官方杂志
	250 S8杂志资源发布
-VIP	196 S8完美丽人
-VIP	199 S8真实性爱录音
-VIP	284 S8原创自摄影片
-VIP	111 S8原创自拍照片
-VIP	195 S8原创真实录音
-VIP	217 S8激情俱乐部
-VIP	411 S8精品下载
-VIP	244 S8信息精品
-VIP	242 S8书吧精品
-VIP	241 S8影吧精品
-VIP	243 S8图吧精品
	189 S8书友互动
	172 S8女优
	175 S8电子书下载
-VIP	291 S8签约作品
-NEEDLOGIN	279 S8首发作品
	13 S8作家写手
	47 S8即时中短
	92 S8旧书库
	51 S8同步连载
	194 S8文心阁
/);
my @REQUEST;
while(@S8_FORUM) {
	my $id = shift(@S8_FORUM);
	if($id =~ m/^\s*-/) {
		shift(@S8_FORUM);
		shift(@S8_FORUM);
		next;
	}
	else {
		$id = [$id,shift(@S8_FORUM)];
	}
	push @REQUEST,[
		$id->[0],
		$id->[1],
		's8' . $id->[0],
		$S8 . $id->[0] . '-1.html',
		$S8 . $id->[0] . '-1.html',
	];
}

my $TOPDIR = shift(@ARGV) || '';
open FO,'|-',$TOPDIR . 'bin/' . 'generate_rss',$TOPDIR or die("$!\n");
foreach(@REQUEST) {
	print FO join("\t",@$_),"\n";
}
close FO;

exit 0;


