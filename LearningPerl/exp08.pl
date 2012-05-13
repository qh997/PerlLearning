#!/usr/bin/env perl
# 第八章 以正则表达式进行匹配

use 5.010;

# 忽略大小写
print "Would you like play a game? ";
$_ = 'YeS';
if (/yes/i) {
    print "In that case, I recommend that you gou blowing.\n";
}

# 用.匹配换行符
$_ = "I saw Barney\ndown at the blowing alley\nwith fred\nlast night.\n";
if (/Barney.*fred/s) {
    print "That string mantions gred after Barney!\n";
}

# 匹配单词边界
my $some_other = "I dream of betty rubble.";
if ($some_other =~ /\brub/) {
    print "Aye, there's the rub.\n";
}

# 模式串中的内插，使用\Q转义
my $what = 'larry|gengs';
$_ = "larry|gengs xxx\n";
if (/^(\Q$what\E)/) {
    print "We saw $what in begining of $_";
}

# 捕获
my $dino = "after 1000 years.";
if ($dino =~ /(\d*) years/) {
    print "That said $1 years.\n";
}
my $dino = "after million years.";
if ($dino =~ /(\d*) years/) {
    print "That said $1 years.\n"; # 匹配成功，但是$1为空字符串
}

# 捕获标签
my $names = 'Fred or Barney';
if ($names =~ m/(?<name1>\w+) (?:and|or) (?<name2>\w+)/) {
    say "I saw $+{name1} and $+{name2}";
}

$names = 'Fred Flinstone or Barney Flinstone';
if ($names =~ m/(?<last_name>\w+) (and|or) \w+ \g{last_name}/) {
    say "I saw $+{last_name}";
}

# 三个不请自来的变量，这也是一个模式测试程序
$_ = "Hello there, neighbor";
if (/\s(\w+),/) {
    say "Matched:  |$`<$&>$'|";
}
else {
    say "No match: |$_|";
}