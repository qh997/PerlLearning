#!/usr/bin/env perl
# 第十四章 字符串与排序

use 5.010;

# 在字符串内用 index 搜索
my $stuff = "Howdy world!";
my $where = index($stuff, "wor");
say $where;

my $where1 = index($stuff, "w");
my $where2 = index($stuff, "w", $where1 + 1);
my $where3 = index($stuff, "w", $where2 + 1);
say "$where1, $where2, $where3";

say my $last_slash = rindex("/etc/passwd", "/");

# 用 substr 处理子串
my $mineral = substr("Fred J. Flintstone", 8, 5);
say $mineral;
my $long = "some very very long string";
my $right = substr($long, index($long, "1"));
say $right;

# 你还可以这样替换
my $string = "Hello, World!";
substr($string, 0, 5) = "Goodbye";
say $string;
substr($string, -20) =~ s/World/Perl/;
say $string;

# 用 sprintf 格式化数据
my $money = sprintf "%.2f", 2.499997;
say $money;

my $number = -1234567891.123;
say "$`<$&>$'" while $number =~ s/^(-?\d+)(\d{3})/$1,$2/;
say $number;

# 高级排序
my @some_numbers = (13, 1, 45, 144, 99, 17, 21, 6);
sub by_number1 {
    # 排序子程序
    if ($a < $b) {-1} elsif ($a > $b) {1} else {0};
}
my @result = sort by_number1 @some_numbers;
say "@result";

sub by_number2 {$a <=> $b}; # 或者可以这样
sub case_insensitive {"\L$a" cmp "\L$b"}; # 字符串排序，不区分大小写

my @numbers = sort {$a <=> $b} @some_numbers; # 更为简单的代码
say "@numbers";

# 两种递减排序
@numbers = reverse sort {$a <=> $b} @some_numbers; # 此时 reverse 是 sort 的修饰词
say "@numbers";
@numbers = sort {$b <=> $a} @some_numbers;
say "@numbers";

# 哈希按值排序
my %score = ("barney" => 195, "fred" => 205, "dino" => 30, "bamm-bamm" => 195);
# 如果得分相同，则按照名字顺序排序
my @winners = sort {$score{$b} <=> $score{$a} or $a cmp $b} keys %score;
say "@winners";