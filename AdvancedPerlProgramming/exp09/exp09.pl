#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

package Stopwatch;
use Time::HiRes qw(time);
sub TIESCALAR {bless \my $time, shift}
sub FETCH {
    my $self = shift;
    return defined $$self ? time - $$self : 0;
}
sub STORE {
    my ($self, $switch) = @_;
    $$self = $switch ? time : undef;
    $self->FETCH;
}

package main;
tie my $timer, 'Stopwatch';
$timer = 1;
1 for (1..1000000);
say $timer;
say $timer;
say $timer = 0;
say $timer = 1;