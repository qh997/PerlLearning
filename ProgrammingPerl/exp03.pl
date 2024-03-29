#!/usr/bin/env perl
# 第三章 

use 5.010;

# 项和列表操作符（左向）
@ary = (1, 3, sort 4, 2, 8);
say @ary;

say (2 + 3) * 4; # 这不是你想要的
say ((2 + 3) * 4);

# 箭头操作符
say $ary -> [2];
$aref = \@ary;
say $aref -> [2]; # 必须是引用、方法名、对象名

# 自增和自减操作符
say ++($foo = '99');
say ++($foo = 'a9');
say ++($foo = 'Az');
say ++($foo = 'zz');

# 表意一元操作符
say -$foo;
say +$foo;
say ~123;
say \$foo;

# 乘号操作符
say '-' x 20;
@ones = (1) x 80;
say scalar @ones;

say 1 << 4;

$_ = 'Hello world';
say 'OK' if length() < 80; # 这里小括号不能省略

say $^T; # 脚本的开始时间

# 范围操作符
# 首先，标量上下文中的范围操作符是有状态的，每一个操作符都有它自己的状态，何谓“有状态”？
# 就是说，每次求值时，得到的结果不仅受当前参与运算的值的影响，而且，还受到上一次运算结果的影响。
# 其次，范围操作符的求值符合如下规律：
# 1，范围操作符的初始状态为假，并且该状态一直维持到左操作数为真之前，并且，在此期间右操作数不会被求值。
# 2，一旦范围操作符的左操作数为真，那么它就返回真，并且该状态一直维持到右操作数为真之前，不过右操作数是否为真需要等到下一次对范围操作符求值时才能知道。（注）
# 3，一旦范围操作符的右操作数为真，那么它就再次返回假，并且该状态一直维持到左操作数为真之前，不过左操作数是否为真需要等到下一次对范围操作符求值时才能知道。（注）
# 特别地，当某一个操作数为一个数字文本的时候，那么范围操作数会把该数字文本和内置变量 $. 的比较结果代替该操作数。
# 
# 注：如果不想拖到下一次，那么就用范围操作符的另外一个版本：“...”（三个小数点，而不是两个）。

like_awk_sed(0, 0);
like_awk_sed(1, 1);
like_awk_sed(0, 0);
like_awk_sed(0, 1);
like_awk_sed(0, 0);
like_awk_sed(1, 0);
like_awk_sed(0, 0);
like_awk_sed(1, 1);
like_awk_sed(0, 0);

sub like_awk_sed {
    say '-' x 20;
    say "$_[0].. $_[1]:", $_[0]..$_[1] ? 'T' : 'F';
    say "$_[0]...$_[1]:", $_[0]...$_[1] ? 'T' : 'F';
}

say '-' x 20;
foreach my $x ( 1..10 ){say $x if $x == 3..$x >= 3};
say '-' x 10;
foreach my $x ( 1..10 ){say $x if $x == 3...$x >= 3};
say '-' x 20;
open FH, 'exp01.pl';
while (<FH>) {
    chomp;
    say "[$_]" if (1 .. /^$/);
}
say '-' x 20;

# 条件操作符
$n = 2;
printf "I have %d camel%s.\n", $n , $n == 1 ? "" : "s";

# 也可以用来赋值
($a_or_b ? $a : $b) = $c;

# 赋值操作符
($global, $constant) = (1, 4);
($tmp = $global) += $constant;
say $tmp;
say $global;
# 等效于
$tmp = $global + $constant;

# 对副本的修改
$old = 'Hello foo world!';
($new = $old) =~ s/foo/bar/;
say "$old => $new";


$a = 0;
$b = 1;
say ($a xor $b);
say (!$a != !$b);