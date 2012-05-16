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