#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

sub ps {say '-' x 45}

# Typeglob
our $x = '101';
{
    local $x;
    say $x // 'undef';
}
say $x // 'undef';

our @x = qw(gonglx changxy xuejj);

*potato = *x;
our ($potato, @potato);
say $potato;
say "@potato";
ps;

## 临时别名
our $b1 = 10;
{
    local *b1;
    *b1 = *a1;
    $b1 = 20;
}
our $a1;
say '$a1 = '.$a1;
say '$b1 = '.$b1;

## 使用 Typeglob 别名
### 高效的参数传递
our @array = (10, 20);
DoubleEachEntry(*array);
say "@array";
sub DoubleEachEntry {
    local *copy = shift;
    foreach (@main::copy) {
        $_ *= 2;
    }
}
my @array_tx = (3, 5, 9);
DoubleEachEntry(\@array_tx); # 可以传递引用
say "@array_tx";
ps;

## 别名存在的问题：变量自杀
our $changxy = 10;
foo(*changxy);
sub foo {
    local *gengs = shift;
    our $gengs;
    say "Before value of gengs: $gengs";
    local $changxy = 100;
    say "After value of gengs: $gengs";
}
ps;

# Typeglob 与引用
say '${*changxy} = '.${*changxy};
our $PI;
## 常量
*PI = \3.14159265358979;
say '$PI = '.$PI;
## 为匿名子例程起名
sub generate_greeting {
    my $greeting = shift;
    return sub {print "$greeting world\n"};
}
*greet = generate_greeting("hello");
greet();
ps;

# 文件句柄，目录句柄及打印格式
