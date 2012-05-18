#!/usr/bin/env perl

use 5.010;

# 语义
$foo = 'foo';
add_bar($foo);
say $foo;

sub add_bar {
    $_[0] .= 'bar'; # 这里其实是在直接修改 $foo
}

## 错误提示
$scalar_context = want_array_test();
@list_context = want_array_test();
want_array_test();

sub want_array_test {
    say defined wantarray ? wantarray ? 'LIST' : 'SCALAR' : 'UNDEFINED';
}

## 作用域问题
@_ = qw(foo bar gengs);
&empty_parameter; # & 形式可以继承当前的 @_
sub empty_parameter {
    say "I have get : [@_]";
}

{
    my $counter = 0; # 私有变量
    sub next_counter {return ++$counter}
    sub prev_counter {return --$counter}
}
say next_counter();
say next_counter();
say next_counter();
say prev_counter();
say $counter; # 这里 $counter 是访问不到的

say next_pitch() for 'a'..'i';
BEGIN {
    my @scale = ('A'..'G');
    my $note = -1;
    sub next_pitch {return $scale[($note += 1) %= @scale]}
}

# 传递引用
($aref, $bref) = func([1, 2, 3], [1, 2, 3, 4]);
say "@$aref has more than @$bref";
sub func {
    my ($cref, $dref) = @_;
    if (@$cref > @$dref) {
        return ($cref, $dref);
    }
    else {
        return ($dref, $cref);
    }
}

# 函数原型
sub try (&$) {
    my ($try, $catch) = @_;
    eval {&$try};
    if ($@) {
        local $_ = $@;
        &$catch;
    }
}
sub catch (&) {shift}

try {
    die "phooey";
}
catch {
    /phooey/ and say "unphooey";
}; # 这里其实是一个函数调用，所以别忘了分号

## 内联常量函数
sub PI () {4 * atan2(1, 1)}
say PI;

# 子例程属性
## locked 和 method 属性
## lvalue 属性
sub canmod ($) : lvalue {$_[0]}
canmod $val1 = 5;
say $val1;

{
    my $val = 10;
    sub set_get_val () : lvalue {$val}
}
set_get_val = 23;
say set_get_val;