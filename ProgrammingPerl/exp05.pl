#!/usr/bin/env perl

use 5.010;

# 模式匹配操作符
$foo = "bar";
$_ = "Hello bar";
say "I found $foo!" if /$foo$/;
say "I found too!" if $_ =~ $foo;

$bar = 'I am FOO-BAR, hello woeld!';
if (lc($bar) =~ /foo-/) { # 绑定操作符优先级相当高，必须使用小括号或项
    say "Nyaa, what's up doc?";
}
else {
    say "That trick never works!";
}

"hot cross buns" =~ /cross/;
say "($`)<$&>($')"; # 还是那三个不请自来的变量

$_ = "xxx cross dds";
say "hi there!" if //; # 如果正则表达式为空，则用上一次成功执行的取代

# m//操作符（匹配）
# 这是一个读取配置文件的很好的例子
$configs = <<END;
name = gengs
pass = 12345#6# # password
fullname = gengshuang #dfs
END

$configs =~ s/(?<=\s)#.*$//mg; # 消除注释
%config = $configs =~ /^\s*(\S+)\s*=\s*(\S+)\s*$/mg;
say $_.' => '.$config{$_} for keys %config;
open FH, $0;
while (<FH>) {
    $frist = $1 if ?(gen.*)?; # ?? 只要匹配成功之后就关闭了
    $last = $1 if /(gen.*)/;
}
say "$frist | $last";

# s/// 操作符（替换）
$_ = '2581';
s/(\d+)/sprintf("%#x", $1)/e;
say;

# 赋值并替换，修改副本的例子
@oldhues = ('bluebird', 'bluegress', 'bluefish', 'the blues');
for (@newhues = @oldhues) {s/blue/red/};
say "@newhues";

# 规范变量中的空白
$string = '  Hello     World!  ';
for ($string1 = $string) {
    s/^\s+//;
    s/\s+$//;
    s/\s+/ /g;
}
say "[$string1]";

# 另一种方法
$string2 = join(' ', split ' ', $string);
say "[$string2]";

# 当全局替换不够“全局”时
say '-' x 45;
$_ = 1234567890.22332112;
say;
say "[$`]<($1)($2)>[$']" while s/(\d+)(\d{3})/$1,$2/;
say;

say '-' x 45;
$_ = "\t\tHello\tworld!\t";
say;
say "[$`]<$&>[$']" while s/\t+/'['.'.' x (length($&) * 8 - length($') % 8).']'/e;
say "$_";

say '-' x 45;
$_ = "this is(a lots (of (parenthese)s))";
say;
say "[$`]<$&>[$']" while s/\([^()]*\)//g;
say;

say '-' x 45;
$_ = "Paris in THE THE THE THE spring.";
say;
say "[$`]<$&>[$']" while s/\b(\w+)\s+\1\b/$1/g;
say;
say '-' x 45;

# 元字符和元符号
$_ = "abc6gdef";
/(??{5+1})/;
say "[$`]<$&>[$']";

# if...then...else
/(?(?<=a)c|e)/;
say "[$`]<$&>[$']";
/(a).*(?(1)c|e)/;
say "[$`]<$&>[$']";
/(?(?{1})c|e)/;
say "[$`]<$&>[$']";

$_ = 'this is(a lots (of (parenthese)s (OK) ))';
say "[$`]<$&>[$']" while /(\()?[^()]+(?(1)\))/g;

# 顺序匹配
$burglar = "Bilbo Baggins";
while ($burglar =~ /b/gci) {
    printf "Found a B at %d\n", pos($burglar) - 1;
}
while ($burglar =~ /i/gi) {
    printf "Found a I at %d\n", pos($burglar) - 1;
}

# 离开之处：\G 断言
$_ = "hello Perl hello world";
/hello\s+(\w+)/g;
say $1;
say pos;
say $1 if /\G\s+hello\s+(\w+)/;

# 捕获
$_ = "abcdefghijklmnopqrstuvwxyz";
/(hi).*(stu)/;
say "The entire matchbegan at $-[0] and ended at $+[0]";
say "The frist  matchbegan at $-[1] and ended at $+[1]";
say "The second matchbegan at $-[2] and ended at $+[2]";

# 变量内插
chomp($answer = <STDIN>);
if    ("SEND"  =~ /^\Q$answer/i) {say "Action is send."}
elsif ("STOP"  =~ /^\Q$answer/i) {say "Action is stop."}
elsif ("ABORT" =~ /^\Q$answer/i) {say "Action is abort."}
elsif ("LIST"  =~ /^\Q$answer/i) {say "Action is list."}
elsif ("EDIT"  =~ /^\Q$answer/i) {say "Action is edit."}

chomp($pattern = <STDIN>);
$_ = "\t22342 i am here";
say "[$`]<$&>[$']" if /$pattern/;

# 正则表达式编译器
#use re "debug";
"Smeagol" =~ /^Sm(.*)g[aeiou]l$/;
say '-' x 45;

"fox" =~ /x+/;
say '-' x 45;

"hello gengs" =~ /\s+(?:c|g)s/;
say '-' x 45;
"xxxxxxx xxxxxyyyyy" =~ /x*y*/;
say '-' x 45;

$a = 'nobody';
$b = 'bodysnatcher';
if ("$a $b" =~ /^(\w+?)(\w+) \2(\w+)$/) {
    say "$2 overlaps in $1-$2-$3";
}
say '-' x 45;
no re "debug";

# 谜一样的模式
# 环顾断言
$_ = "Paris in THE THE THE THE spring.";
s/\b(\w+)\s+(?=\1\b)//gi;
say;
$_ = " The clothes you DON DON't fit.";
s/\b(\w+)\s+(?=\1\b(?!'\w))//gi;
say;
$_ = " that that particular";
s/\b(\w+)\s+(?=\1\b(?!'\w|\sparticular))//gi;
say;
@thatthat = qw(particular nation);
local $" = '|';
$_ = " that that particular";
s/\b(\w+)\s+(?=\1\b(?!'\w|\s(?:@thatthat)))//gi;
say;

$_ = 'weird';
s/(?<!c)ei/ie/; # 除了在 C 后面以外，I 在 E 前面
say;

# 非回溯子模式
# 捕获连续行
$_ = <<'END';
sh = Makefiel.SH xxx \
    line 2 \
    line 3
newline
abcde \
fghi \
123
xxxxxx
END

while (/((?>.+)(?:(?<=\\)\n.*)+)/g) {
    say "GOT $. : $1\n";
}

# 替换计算
$_ = "Preheat oven to 233C.";
s/\b(\d+\.?\d*)C\b/int($1 * 1.8 + 32)."F"/ge;
say;

$_ = "I have 4 + 9 / 3 dollars an 8 / 2 + 1 cents.";
s/((?:\d+\.?\d*\s*[-+*\/]\s*)+\d+\.?\d*)/$1/gee;
say "[$`]<$&>[$']";
say;