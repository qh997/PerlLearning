#!/usr/bin/env perl

use 5.010;

# next 操作符
@array = qw(a b c a a cd dd c);
while (<@array>) {
    foreach (split) {
        $total++;
        next if /\W/;
        $valid++;
        $count{$_}++;
    }
}

say "total things = $total, valid words = $valid";
foreach (sort keys %count) {
    say "$_ was seen $count{$_} times.";
}

# “定义否”操作符 5.010
my $Verbose = $ENV{VERBOSE} // 1;
say "I can talk to you!" if $Verbose;

foreach $try (0, undef, '0', 1, 25) {
    print "Trying [$try]\t--->";
    my $value = $try // 'default';
    say "\tgot [$value]";
}

printf "%s\n", $name // 'NO_NAME';