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
=del
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
=cut

## 迭代器与流
sub even_number_printer_gen {
    my $input = shift;
    if ($input % 2) {$input++}
    my $rs = sub {
        say "$input";
        $input += 2;
    };
    return $rs;
}

my $iterator = even_number_printer_gen(30);
for (my $i = 0; $i < 10; $i++) {
    &$iterator();
}
ps;

### 随机数生成
sub my_srand {
    my $seed = shift;
    my $rand = $seed;
    return sub {$rand = ($rand * 21 + 1) % 1000}
}

my $random1 = my_srand(100);
my $random2 = my_srand(1099);
for (1..10) {
    say &$random1().' '.$random2->();
}
ps;

## 闭包与对象的对比
