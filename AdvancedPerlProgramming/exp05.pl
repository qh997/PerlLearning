#!/usr/bin/perl
# 第五章 Eval

use 5.010;
use strict;
use warnings;

sub ps {say '-' x 45}

# 字符串形式：表达式计算
my $str = 'my $c=$a+$b;print "\$c = $c\n";';
my ($a, $b) = (10, 20);
eval $str;

$str = '$a++;$a+$b;';
my $c = eval $str;
say "\$c = $c";
ps;

# 代码块形式：例外处理
eval {
    $a = 10; $b = 0;
    $c = $a / $b;
};
print "Error : $@";

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
    $a = 4 / 0;
}
catch {
    chomp;
    say "There is an error : $_";
};

# 应用 Eval 来进行表达式计算
## 替换中的表达式计算
my $line = "Expression Evaluation";
$line =~ s/(\w+)/scalar(reverse($1))/ge;
say $line;
ps;

# 在超时中应用 Eval
sub time_out {
    die "Time out!";
}
$SIG{ALRM} = \&time_out;
eval {
    alarm(3);
    my $bug = <>;
    alarm(0);
};
print $@ if $@;