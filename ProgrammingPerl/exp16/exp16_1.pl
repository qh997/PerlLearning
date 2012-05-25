#!/usr/bin/env perl

use 5.010;
use strict;
use warnings;

sub ps {say '-' x 45}

# 管道
## 匿名管道
{
    open SPOOLER, "| cat -v | grep 'th'"
        or die "can't fork: $!";
    local $SIG{PIPE} = sub {die "spooler pipe broke"};
    print SPOOLER "stuff\n";
    print SPOOLER "something\n";
    close SPOOLER or die "bad spool: $! $?";
}
ps;

open STATUS, "-|", "netstat", "-an"
    or die "can't fork: $!";
while (<STATUS>) {
    next unless /^(tcp|udp)/;
    print;
}
close STATUS or die "bad netstat: $! $?";
ps;

## 自言自语
$| = 1;
if (open(TO, "|-")) {
    print TO "from parent";
    close TO;
} 
else {
    my $tochild = <STDIN>;
    say "CHLD: $tochild";
    exit;
}

if (open(FROM, "-|")) {
    my $toparent = <FROM>;
    say "PART: $toparent";
    close FROM;
}
else {
    print STDOUT "from child";
    exit;
}
ps;

tee("/tmp/foo", "/tmp/bar", "/tmp/glarch");

while (<>) {
    print "$ARGV at line $. => $_";
}
close STDOUT or die "can't close STDOUT: $!";

sub tee {
    my @output = @_;
    my @handles = ();
    for my $path (@output) {
        my $fh;
        unless (open($fh, ">", $path)) {
            warn "can't write to $path: $!";
            next;
        }

        push @handles, $fh;
    }

    return if my $pid = open(STDOUT, "|-");
    die "can't fork: $!" unless defined $pid;

    while (<STDIN>) {
        for my $fh (@handles) {
            print $fh $_ or die "tee output failed: $!";
        }
    }
    for my $fh (@handles) {
        close $fh or die "tee closing failed: $!";
    }
    exit;
}

open(STDOUT, ">/dev/pts/6") or die "can't open STDOUT: $!";
say fileno(STDOUT);
ps;

my $string = forksub(\&badfunc, "arg");
say $string;

sub forksub {
    my $kidpid = open my $self, "-|";
    defined $kidpid or die "can't fork: $!";
    $_[0]->(@_[(1..$#_)]), exit unless $kidpid;
    local $/ unless wantarray;
    return <$self>;
}

sub badfunc {
    print "badfunc: @_\n";
    print "badfunc: bad\n";
}
ps;

## 双向通信
use IPC::Open2;
local (*Reader, *Writer);
my $pid = open2(\*Reader, \*Writer, "bc -l");
my $sum = 2;
for (1..5) {
    print Writer "$sum * $sum\n";
    chomp($sum = <Reader>);
}
close Reader;
close Writer;
waitpid($pid, 0);
print "sum is $sum\n";
ps;

pipe(FROM_PARENT, TO_CHILD) or die "pipe: $!";
pipe(FROM_CHILD, TO_PARENT) or die "pipe: $!";
select((select(TO_CHILD), $| = 1)[0]);
select((select(TO_PARENT), $| = 1)[0]);

if ($pid = fork) {
    close FROM_PARENT; close TO_PARENT;
    print TO_CHILD "Parent Pid $$ is sending this\n";
    chomp(my $line = <FROM_CHILD>);
    print "Parent Pid $$ just read this:'$line'\n";
    close FROM_CHILD; close TO_CHILD;
    waitpid($pid, 0);
}
else {
    die "can't fork: $!" unless defined $pid;
    close FROM_CHILD; close TO_CHILD;
    chomp(my $line = <FROM_PARENT>);
    print "Child Pid $$ just read this:'$line'\n";
    print TO_PARENT "Child Pid $$ is sending this\n";
    close FROM_PARENT; close TO_PARENT;
    exit;
}
ps;