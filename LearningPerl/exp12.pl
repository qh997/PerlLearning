#!/usr/bin/env perl

use 5.010;

# 省略参数的文件检测
$_ = "exp05.pl";
my $size_in_K = (-s) / 1000; #注意-s的小括号
say $size_in_K;

# 同一文件的多项属性测试
$file = "exp11.pl";
if (-r $file and -w _) { # _ 就是虚拟文件句柄
    say "$file is readable and writable!";
}

# 栈式文件测试操作
if (-r -w -x -o $file) {
    say "$file is readable and writable and executable!";
}

chomp($file = `pwd`);
if (-d $file and -s _ < 512) {
    say "The directory is less than 512 bytes!";
}

# localtime 函数
my $timestamp = 1180630098;
my $date = localtime $timestamp;
say $date;

# 按位运算操作
say '10 & 12 = ', 10 & 12;
say '10 | 12 = ', 10 | 12;
say '10 ^ 12 = ', 10 ^ 12;
say '6  << 2 = ', 6  << 2;
say '25 >> 2 = ', 25 >> 2;