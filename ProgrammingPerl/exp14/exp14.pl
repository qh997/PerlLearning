#!/usr/bin/env perl
# 第十四章 绑定变量

use strict;
use warnings;
use 5.010;

use ScalarFile;

sub ps {say '-' x 54}

# 绑定标量
package Centsible;
sub TIESCALAR {bless \my $self, shift}
sub STORE {${$_[0]} = $_[1]}
sub FETCH {sprintf "%0.2f", ${+shift}}

package main;
my $buckref = tie my $bucks, 'Centsible';
$bucks = 45;
say $bucks;
$bucks *= 1.0715;
$bucks *= 1.0715;
say "That will be $bucks, please.";
ps;

my $bucks1 = $bucks;
say '$bucks1 = '.$bucks1;
$bucks1 *= 1.0715;
say '$bucks1 = '.$bucks1;
ps;

my $bucks2 = \$bucks;
say '$buckref = '.$buckref;
say '$bucks2  = '.$bucks2;
say '$$bucks2 = '.$$bucks2;
$$bucks2 *= 1.0715;
say '$$bucks2 = '.$$bucks2;
ps;

## 标量绑定方法
tie my $string, 'ScalarFile', 'camel.lot' or die;
say $string;
$string = "Here is the frist line of camel.lot\n";
$string .= "And here is another line, automatically appended.\n";
say ScalarFile->count;

untie $string;
say ScalarFile->count;
$string = "I am here.";
say $string;
ps;

## 神奇地消除 $_
{
#    no Underscore;
    my @test = (
        Assignment => sub {$_ = 'Bad'},
        Reading => sub {print},
        Matching => sub {my $x = /badness/},
        Chop => sub {chop},
        Filetest => sub {-x},
        Nesting => sub {for (1..3) {print}},
    );

    while (my ($name, $code) = splice(@test, 0, 2)) {
        print "Testing $name: ";
        eval {&$code};
        print $@ ? "detected" : " missed";
        print "\n";
    }

#    import Underscore;
    ps;
}

# 绑定数组
{
    package ClockArray;
    use Tie::Array;
    our @ISA = ('Tie::StdArray');
    sub FETCH {
        my ($self, $place) = @_;
        $self->[$place % 12];
    }
    sub STORE {
        my ($self, $place, $value) = @_;
        $self->[$place % 12] = $value;
    }
}

package main;
tie my @array, 'ClockArray';
@array = ('a'..'z');
say "@array";
ps;

## 数组绑定方法
use BoundedArray;
tie my @bd_array, 'BoundedArray', 3;
$bd_array[0] = 'fine';
$bd_array[1] = 'good';
push @bd_array, 'great';
say $bd_array[2];
say pop @bd_array;
say shift @bd_array;
say scalar @bd_array;
ps;

## 有用的表示法
package RandInterp;
sub TIEARRAY {bless \my $self}
sub FETCH {int rand $_[1]}

package main;
tie my @rand, 'RandInterp';
for (1, 10, 100, 1000) {
    say "A random integer less then $_ would be $rand[$_]";
}
ps;

# 绑定散列
use AppendHash;
tie my %ahash, 'AppendHash';
$ahash{xy} = 'u';
$ahash{xy} = 'n';
$ahash{xy} = 'g';
say "@{$ahash{xy}}";
ps;

## 散列绑定方法
use DotFiles;
(tie my %dot, 'DotFiles')->debug;
say for keys %dot;
delete $dot{minttyrc};

# 绑定文件句柄