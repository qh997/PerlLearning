#!/usr/bin/env perl

use 5.010;
use strict;
use sigtrap;
use warnings;
use IO::Socket;

sub ps {say '-' x 45}

# 套接字
my $server = IO::Socket::INET->new(
    LocalPort => '8517',
    Type => SOCK_STREAM,
    Reuse => 1,
    Listen => 10,
);

while (my $client = $server->accept()) {
    say $client->peerhost();
    chomp(my $answer = <$client>);
    print "Client => $answer\n";
    print $client `date`;
}

close $server;