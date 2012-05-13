#!/usr/bin/env perl
# 第十五章 智能匹配与 given-when 结构

use 5.010;

# 智能匹配操作符
$name = "gengs Fred changxy lit";
say "I found Fred in the name!" if $name ~~ /Fred/;

my %names = (
    gengs => 1,
    Fred => 2,
    changxy => 3,
    lit => 4,
);
say "I found a key matching 'Fred'" if %names ~~ /Fred/;
say "I found a key matching 'Fred'" if 'Fred' ~~ %names;

@name1 = (a, b, c);
@name2 = (a, b, c);
say "The arrays are the same!" if @name1 ~~ @name2;

my @nums = qw(1 2 3 27 42);
my $result = max(@nums);
say "The result [$result] is one of the input values (@nums)"
    if $result ~~ @nums;

sub max {
    my $max_so_far = shift;
    foreach (@_) {
        if ($_ > $max_so_far) {
            $max_so_far = $_;
        }
    }
    $max_so_far;
}

# given 语句
given('fred') {
    when (/fred/i) {say "Name has fred in it"; continue}
    when (/^Fred/) {say "Name starts with Fred"; continue}
    when ('Fred')  {say "Name if Fred"; break}
    default        {say "I don't see a Fred"}
}

say "Here is a foreach using given...";
@name = qw(gengs Fred changxy lit);
foreach (@name) {
    say;
    when (/fred/i) {say "Name has fred in it"; continue}
    when (/^Fred/) {say "Name starts with Fred"; continue}
    when ('Fred')  {say "Name if Fred";}

    say "Moving to default...";
    default        {say "I don't see a Fred"}
}