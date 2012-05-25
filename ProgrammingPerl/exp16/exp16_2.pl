#!/usr/bin/env perl

use 5.010;
use strict;
use warnings;

sub ps {say '-' x 45}

# 管道
## 命名管道
use Fcntl;
chdir;
my $fpath = '.signature';
$ENV{PATH} .= ":/usr/games";

unless (-p $fpath) {
    if (-e _) {
        die "$0: won't overwrite .signature\n";
    }
    else {
        require POSIX;
        POSIX::mkfifo($fpath, 0666) or die "can't mknod $fpath: $!";
        warn "$0: created $fpath as a named pipe\n";
    }
}

while (1) {
    die "Pipe file disappeared" unless -p $fpath;
    sysopen(FIFO, $fpath, O_WRONLY)
        or die "can't write $fpath: $!";
    print FIFO "John Smith (smith\@host.org)\n", `fortune -s`;
    close FIFO;
    select(undef, undef, undef, 0.2);
}