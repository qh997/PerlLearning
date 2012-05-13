#!/usr/bin/env perl
# 第九章 用正则表达式处理文本

use 5.010;

# 替换操作
$_ = "He's out bowling with Barney tonight.";
s/Barney/Fred/;
say $_;
s/with (\w+)/against $1's team/;
say $_;

# 一连串的替换
$_ = "green scaly dinosaur";
s/(\w+) (\w+)/$2, $1/;
say $_;
s/^/huge, /;
say $_;
s/,.*een//;
say $_;
s/green/red/;
say $_;
s/\w+$/($`!)$&/;
say $_;
s/\s+(!\W+)/$1 /;
say $_;
s/huge/gigantic/;
say $_;

# 全局替换
$_ = "home, sweet home!";
s/home/cave/g;
say $_;

# 删除首尾的空白字符
s/^\s+//;
s/\s+$//;
s/^\s+|\s+$//g; # 这个性能差一点

# 大小写转换
$_ = "I saw Barney with Fred.";
s/(fred|barney)/\U$1/gi;
say $_;
s/(fred|barney)/\L$1/gi;
say $_;
s/(\w+) with (\w+)/\U$2\E with $1/i;
say $_;
s/(fred|barney)/\u$1/gi;
say $_;
s/(fred|barney)/\u\L$1/gi; # 首字母大写
say $_;
$name = 'changxy';
print "Hello, \L\u$name\E, would you like to play a game?\n"; # 在双引号字符串中同样

# split 操作符
@fields = split /:/, ":::a:b:c:::";
print "[$_]" for @fields;
say '';
@fields = split /:/, ":::a:b:c:::", -1;
print "[$_]" for @fields;
say '';
@fields = split; # 等效于 split /\s+/, $_;

# 列表上下文中的 m//
$_ = "Hello there, neighbor!";
($frist, $second, $third) = /(\S+) (\S+), (\S+)/;
say "$second is my $third";
$text = "Fred dropped a 5 ton granite block on Mr. Slate";
@words = $text =~ /([a-z]+)/ig;
say "Result: @words";

# 跨行的模式匹配
$_ = "I'm much better\nthan Barney is\nnat bowling,\nWilma.\n";
say "Found 'wilma' at start of line" if /^wilma\b/im;

# 一次更新多个文件
my $date = localtime;
$^I = '.bak';
while (<>) {
    s/$/ gengs/;
    print;
}
# 从命令行进行在线编辑
# $ perl -p -i.bak -w -e 's/$/ gengs/' text01