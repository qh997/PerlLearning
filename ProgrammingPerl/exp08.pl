#!/usr/bin/env perl
# 第八章 引用

use 5.010;

# 创建引用
## 反斜杠操作符
$foo = 'foo';
$scalarref = \$foo;
say "$scalarref -> $$scalarref";
say '-' x 45;

## 匿名数据
### 匿名数组组合器
$arrayref = [
    ["john", 47, "brown", 186],
    ["mary", 23, "bazel", 128],
    ["bill", 35, "blue", 157],
];
say $arrayref->[0]->[2];
say ${$$arrayref[1]}[0];
say '-' x 45;

### 匿名散列组合器
$table = {
    john => [47, "brown", 186],
    mary => [23, "bazel", 128],
    bill => [35, "blue", 157],
};
say $table->{bill}->[2];
say ${${$table}{john}}[0];

sub hashem {+{@_}}; # 使用 + 消除 {} 歧异，现在是引用了。否则是一个代码块
$likes = hashem('changxy', 1, 'xuejj', 2);
say keys %$likes;
say '-' x 45;

### 匿名子例程组合器
$coderef = sub {say "Boink!"};
&$coderef;
say '-' x 45;

## 对象构造器
## 句柄引用
splutter(\*STDOUT);
splutter(*STDOUT);
sub splutter {
    my $fh = shift;
    print $fh = "her um well a hmmm\n";
}
say '-' x 45;

# 符号表引用
$scalarref = *foo{SCALAR};
say \$foo." = $scalarref";
say '-' x 45;

# 使用硬引用
## 把变量当做变量名使用
$foo = "three humps";
$scalarref = \$foo;
$camel_model = $$scalarref;
say $scalarref;
say $camel_model;

$refrefref = \\\"howdy";
say $$$$refrefref;
say '-' x 45;

## 把 BLOCK 当做变量名用
say ${${${$refrefref}}};
%this_is_hash = (
    to_scalar => \$foo,
);
say ${$this_is_hash{to_scalar}};
say '-' x 45;

## 使用箭头操作符
say $arrayref->[0]->[2];

$array[3]->{English}->[0] = "January"; # $array[3] 并不存在，这一切都是自动激活的
say $array[3]->{English}->[0];

push @{$array[2]->{hello}}, "foobar"; # 看，自动的
say $array[2]->{hello}->[0];
say $array[2]{hello}[0]; # 箭头可以省略

$answer[0][0][1] = 42; # 多维数组
say $answer[0][0][1];
say "$answer[0]=>$answer[0][0]=>$answer[0][0][1]";
say '-' x 45;

## 使用对象方法
### 伪散列
$john = [{age => 1, eyes => 2, weight => 3}, 47, "brown", 186]; # 现在 Perl 已经不支持这样的魔术了

## 硬引用的其他技巧
@reflist = \(@x); # map (\$_) @x
@reflist = \($s, @a, %h, &f); # (\$s, \@a, \%h, \&f)
say ref($_) for @reflist;

say "My sub returned @{[mysub(1, 2, 3)]} that time.";
say "My sub returned @{[scalar mysub(1, 2, 3)]} now.";
sub mysub {
    return map {$_ + 1} @_;
}
say '-' x 45;

## 闭包
{
    my $critter = "camel";
    $critterref = sub {return $critter};
}
say $critterref->();

sub make_saying {
    my $salute = shift;
    my $newfunc = sub {
        my $target = shift;
        say "$salute, $target!"
    };

    return $newfunc;
}

$f = make_saying("Howdy");
$g = make_saying("Greetings");

$f->("world");
$g->("earthings");
say '-' x 45;

### 用闭包作函数模板
@colors = qw(red blue green yellow orange purple wiolet);
for my $name (@colors) {
    no strict 'refs';
    *$name = *{uc $name} = sub {"<FONT COLOR='$name'>@_</FONT>"};
}
say red('gengs', 'sgeng');
say BLUE('sgeng', 'gengs');
say wiolet('sgeng', 'gengs');
say '-' x 45;

### 嵌套子例程
sub outer {
    my $x = $_[0] + 35;
    my $inner = sub {return $x * 19};
    return $x + $inner->();
}
say outer(2);
say '-' x 45;

# 符号引用
our $value = "global";
{
    my $value = "private";
    print "Inside, mine is ${value},";
    print "but ours is ${'value'}.\n";
}
print "Outside, ${value} is again ${'value'}.\n";
say '-' x 45;

# 大括号、中括号和引号
$push = "pop on ";
say "${push}over";
say '-' x 45;

## 引用不能当作散列键用
use Tie::RefHash;
tie my %h, 'Tie::RefHash';
%h = (
    ["this", "here"]  => "at home",
    ["that", "there"] => "elsewhere",
);
while (my ($keyref, $value) = each %h) {
    say "@$keyref is $value";
}
say '-' x 45;

tie %h, 'Tie::RefHash';
$a = [];
$b = {};
$c = \*main;
$d = \"gunk";
$e = sub { 'foo' };
%h = ($a => 1, $b => 2, $c => 3, $d => 4, $e => 5);
$a->[0] = 'foo';
$b->{foo} = 'bar';
for (keys %h) {
    print ref($_), "\n";
}
say '-' x 45;

tie %h, 'Tie::RefHash::Nestable';
$h{$a}->{$b} = 1;
for (keys %h, keys %{$h{$a}}) {
    print ref($_), "\n";
}