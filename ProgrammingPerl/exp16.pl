#!/usr/bin/env perl

use 5.010;
use strict;
use warnings;

sub ps {say '-' x 45}

print " $_" for sort keys %SIG;
print "\n";

say "PID = $$";

$SIG{INT} = sub {die "\nOutta here!\n"};

sub catch_zap {
    my $signme = shift;
    our $shucks++;
    die "\nSomebody sent me a SIG$signme!";
}

$SIG{INT} = \&catch_zap;
$SIG{QUIT} = \&catch_zap;
ps;

## 收割僵死进程
use POSIX ":sys_wait_h";
my $zombies = 0;
$SIG{CHLD} = sub {$zombies--; say "received SIG$_[0] $?"};
for (1..2) {
    my $pid = fork;
    $zombies++;
    if (defined($pid) && $pid == 0) {
        say "$_ : myPID = $$";
        sleep $_;
        say "$_ : myPID = $$ die";
        exit 0;
    }
}
my $kid = waitpid(-1, WNOHANG);
say "\$kid = $kid";
while ($zombies) {}
say 'I am here!';
ps;

## 给慢速操作调速
eval {
    local $SIG{ALRM} = sub {die "alarm"};
    alarm 1;
    sleep 3;
    alarm 0;
};
print $@ if $@;
ps;

# 文件
## 文件锁定
use Fcntl qw(:DEFAULT :flock);
open(FH, "< exp16.txt") or die "can't open exp16.txt: $!";
flock(FH, LOCK_SH) or die "can't lock exp16.txt: $!";

sysopen(FH, "exp16.txt", O_WRONLY | O_CREAT)
    or die "can't open exp16.txt: $!";
flock(FH, LOCK_EX)
    or die "can't lock exp16.txt: $!";
truncate(FH, 0)
    or die "can't truncate exp16.txt: $!";
print FH "abc\ndef\n";
close FH;
ps;

## 传递文件句柄
open(INPUT, "< exp16.txt") or die "can't open exp16.txt: $!";
if (my $pid = fork) {
    waitpid($pid, 0);
}
else {
    defined $pid or die "can't fork: $!";
    while (<INPUT>) {print "$.: $_";}
    exit;
}

my $fdspec = '<&='.fileno(INPUT);
system('nl', $fdspec);