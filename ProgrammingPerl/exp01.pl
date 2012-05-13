#!/usr/bin/env perl
# 第一章 Perl 概述

use 5.010;

# 文件句柄
print STDOUT "Enter a number: ";
chomp($number = <STDIN>);
say STDOUT "The number is $number.\n";

# 字符串操作符
$a = 123;
$b = 456;
say '$a + $b = ', $a + $b;
say '$a . $b = ', $a . $b;

$b = 3;
say '$a * $b = ', $a * $b;
say '$a x $b = ', $a x $b;

print $a.' is equal to '.$b."\n";
print $a, ' is equal to ', $b, "\n";
print "$a is equal to $b\n";

# 赋值操作符
$val = 0;
$val ||= 'false';
say $val;
$val = 1;
$val &&= 'true';
say $val;

$temp = 20;
($temp *= 9/5) += 32;
say $temp;

# 逻辑操作符
1 or say "This is a 1";
0 or say "This is a 0";

# 循环结构
$tickets_sold = $number;
while ($tickets_sold < 10) {
    say 10 - $tickets_sold, " tickets are available.";
}
continue {
    $tickets_sold++;
}

LINE: while (<STDIN>) {
    last LINE if /^\n$/;
    next LINE if /^#/;
    say 'Available input!';
}
continue {
    print "Input is : $_";
}

# 正则表达式
$_ = "fred xxxxxxxxx barney";
s/x*/y/; # 有问题，x*会匹配 fred 前的空字符串
say;
