#!/usr/bin/env perl
# 第十三章 目标操作

use 5.010;

# 在目录树中移动
chdir '/etc' or die "cannot chdir to /etc: $!";
print `pwd`;

# 文件名通配
my @all_files = glob ".* *";
say for @all_files;

# 目录句柄
my $dir_to_process = "/etc";
opendir DH, $dir_to_process or die "Cannot open $dir_to_process: $!";
foreach (readdir DH) {
    say "one file in $dir_to_process is $_";
}
closedir DH;

# 建立及移除目录
my $name = "fred";
my $permissions = "0755";
mkdir $name, oct($permissions);
unlink $name or warn "failed on $name : $!\n";
rmdir $name or warn "cannot rmdir $name : $!\n";

# 修改时间戳
my $now = time;
my $ago = $now - 24 * 60 * 60;
say "$now => $ago";
utime $now, $ago, glob "*.gengs";