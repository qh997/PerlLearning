#!/usr/bin/env perl
# 第八章 引用

use 5.010;

# 创建引用
## 反斜杠操作符
$foo = 'foo';
$scalarref = \$foo;
say "$scalarref -> $$scalarref";

## 匿名数据
### 匿名数组组合器
$arrayref = [
    ["john", 47, "brown", 186],
    ["mary", 23, "bazel", 128],
    ["bill", 35, "blue", 157],
];
say $arrayref -> [0] -> [2];
say ${$$arrayref[1]}[0];

### 匿名散列组合器
$table = {
    john => [47, "brown", 186],
    mary => [23, "bazel", 128],
    bill => [35, "blue", 157],
};
say $table -> {bill} -> [2];
say ${${$table}{john}}[0];

sub hashem {+{@_}}; # 使用 + 消除 {} 歧异，现在是引用了。否则是一个代码块
$likes = hashem('changxy', 1, 'xuejj', 2);
say keys %$likes;

### 匿名子例程组合器
$coderef = sub {say "Boink!"};
&$coderef;

## 对象构造器
## 句柄引用
splutter(\*STDOUT);
splutter(*STDOUT);
sub splutter {
    my $fh = shift;
    print $fh = "her um well a hmmm\n";
}

# 符号表引用
$scalarref = *foo{SCALAR};
say \$foo." = $scalarref";

# 使用硬引用