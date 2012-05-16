#!/usr/bin/env perl

use 5.010;

# 简单语句
do {
    chomp($line = <STDIN>);
    next if $line eq "next"; # 修饰词不接受循环标记
    say "> $line";
} until $line eq ".";

# 混合语句
open(FH, "exp01.pl") or die "Can't open exp01.pl: $!";
close FH;

# foreach 循环
@ary1 = (1, 2, 3, 4, 5);
@ary2 = (1, 2, 3, 4, 5);
WID: foreach $this (@ary1) {
    JET: foreach $that (@ary2) {
        next WID if $this > $that; # 直接跳出内循环
        $this += $that;
    }
}
say "@ary1";

# 循环控制
$\ = 1;
while (<>) {
    chomp;
    say "= {$_}";
    if (s/\\$//) {
        chomp($_ .= <>);
        say "if<$_>";
        redo unless eof; # 这里eof()会等待输入，但并不会从STDIN中将这条输入拿出来
    }

    say "> [$_]";
}

@argv = qw(-d -xx -ixx hehehe);
ARG: while (@argv && $argv[0] =~ s/^-(?=.)//) {
    say '-' x 15;
    say "ARG: [@argv]";
    OPT: for (shift @argv) {
        say "OPT: ($_) <= [@argv]";
        m/^$/      && do {say 'Empty';              next ARG;};
        m/^-$/     && do {say "[$_] last";          last ARG;};
        s/^d//     && do {say 'Debug_Leavel++';     redo OPT;}; # redo 不重新计算循环条件
        s/^l//     && do {say 'Generate_Listing++'; redo OPT;};
        s/^i(.*)// && do {say "$1 or .bak";         next ARG;};
        say "Unkonw option: $_";
    }
}

# 裸块
($x, $y, $z) = (1, 3, 10);
DO_LAST:{
    do {
        DO_NEXT: {
            say "$x : $y";
            next DO_NEXT if $x == $y;
            last DO_LAST if $x == $y ** 2;
            say 'I am here!';
        }
    } while $x++ <= $z;
}

# 情况（case）结构
$_ = 'def';
SWITCH: {
    /^abc/ && do {
        say 'It is : abc';
        last SWITCH;
    };

    /^def/ && do {
        say 'It is : def';
        last SWITCH;
    };

    say 'It is : nothing';
}

# 这也是一种switch结构
$_ = 'abc';
for ($_) {
    /^abc/ && do {
        say 'This is : abc';
        last;
    };
    /^def/ && do {
        say 'This is : def';
        last;
    };
    say 'This is : nothing';
}

# goto
call_goto();

sub call_goto {
    say 'call_goto start';
    $subname = \&goto_in;
    goto $subname;
    say 'call_goto finished';
}

sub goto_in {
    say "go to : i am here!"
}

# 词法作用域的变量：my
{
    my $state = 0;

    say on();
    say off();
    say toggle();

    sub on {$state = 1}
    sub off {$state = 0}
    sub toggle {$state = !$state}
}
say "\$state = $state"; # $state 超过作用域了

my $state = 23;
{
    my $state = $state; # 为 $state 做了一个镜像
    $state++;
    say "IN : $state";
}
say "OUT : $state"; # 还是原来的值

# 词法作用域全局声明：our
our $PROGRAM_NAME = "waiter";
{
    our $PROGRAM_NAME = "server";
    say "IN : $PROGRAM_NAME";
}
say "OUT : $PROGRAM_NAME";

{
    local our $MY_NAME = "gengs"; # 取一个 local 自己的变量
    say "IN : $MY_NAME";
}
say "OUT : $MY_NAME";

# 动态作用域变量：local
{
    local $var = $newvalue
    #...
}
# 可以认为是运行时赋的值
{
    $oldvalue = $var;
    $var - $newvalue;
    #...
}
continue {
    $var = $oldvalue;
}