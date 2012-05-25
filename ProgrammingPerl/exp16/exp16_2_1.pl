#!/usr/bin/env perl

use 5.010;
use Fcntl;
use strict;
use warnings;

sub ps {say '-' x 45}

chdir;
my $fpath = '.signature';
die "Pipe file disappeared" unless -p $fpath;
while (1) {
    ps;
    sysopen(FIFO, $fpath, O_RDONLY)
        or die "can't write $fpath: $!";
    print <FIFO>;
    close FIFO;
}