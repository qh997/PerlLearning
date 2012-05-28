#!/usr/bin/perl
# 第四章 子例程引用与闭包

use 5.010;
use strict;
use warnings;

sub ps {say '-' x 45}

# 使用子例程引用
sub generate_greeting {
    my $greeting = shift;
    return sub {
        my $subject = shift;
        say "$greeting $subject";
    }
}

my $rs1 = generate_greeting("hello");
$rs1->("gengs");
ps;

# 闭包的内幕
our $greeting;
sub generate_greeting_local {
    local $greeting = shift;
    return sub {
        my $subject = shift;
        say "$greeting $subject";
    }
}
my $rs2 = generate_greeting_local("hello");
$greeting = "goodbye";
$rs1->("gengs");
ps;

# 闭包的应用
## 将闭包用作“智能”回调
use Tk;
my $topwindow = MainWindow->new();
CreatButton($topwindow, "hello");
CreatButton($topwindow, "world");
Tk::MainLoop();

sub CreatButton {
    my ($parent, $title) = @_;
    $parent->Button(
        '-text' => $title,
        '-fg' => 'red',
        '-command' => sub {say "Button $title pressed."},
    )->pack();
}