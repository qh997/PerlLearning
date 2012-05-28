#!/usr/bin/perl
# 第一章 数据引用与匿名存储

use 5.010;
use strict;
use warnings;

sub ps {say '-' x 45}

# 对已有变量的引用
my $a = "mama mia";
my $ra = \$a;
say $$ra;

my $ref_str = \"Hello APP";
say "$ref_str = $$ref_str";

my @array = qw(a b c);
my $ref_array = \@array;
say '@$ref_array[0, 2] = '.@$ref_array[0, 2];
say '$ref_array->[2] = '.$ref_array->[2];
ps;

# 使用引用
## 向子例程传递数组和散列表
my @array1 = (1, 2, 3);
my @array2 = (4, 5, 6, 7);
add_arrays(\@array1, \@array2);
say "\@array1 = [@array1]";
sub add_arrays {
    my ($rarray1, $rarray2) = @_;
    my $len2 = @$rarray2;
    for (my $i = 0; $i < $len2; $i++) {
        $rarray1->[$i] += $rarray2->[$i];
    }
}
ps;

## 匿名存储的引用
$ra = [1, "hello"];
say '$ra->[1] = '.$ra->[1];
my $rh = {flock => 'birds', pride => "lions"};
my $rs;
$rs = \do{my $s = 'hello world!'}; # 匿名标量
say $$rs;
{$rs = \my $s};
say $rs;
ps;

## 一种更加通用的规则
sub test {
    return \$a;
}
$a = 10;
my $b = ${test()};
say $b;
ps;

# 嵌套数据结构
my %sue = (
    name => 'Sue',
    age  => '45',
);
my %john = (
    name => 'john',
    age  => '20',
);
my %peggy = (
    name => 'Peggy',
    age  => '16',
);

$sue{children} = [\%john, \%peggy];
say $sue{children}[0]{name};
ps;

# 引用的查询
say 'ref $a = '.ref $a;
say 'ref $rs = '.ref $rs;
say 'ref $ra = '.ref $ra;
say 'ref $rh = '.ref $rh;

# 符号引用
no strict 'refs';
our $x = 10;
my $var = "x";
say '$$var = '.$$var;