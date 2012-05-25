#!/usr/bin/env perl

use 5.010;
use strict;
use sigtrap;
use warnings;
use IO::Socket;

sub ps {say '-' x 45}

my $socket = IO::Socket::INET->new("localhost:8517");
print $socket "Hello Server!\n";
chomp(my $answer = <$socket>);
print "Server => $answer\n";
close $socket;