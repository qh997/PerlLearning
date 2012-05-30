#!/usr/bin/perl

use Carp;
use 5.010;
use strict;
use warnings;

tie my $whowasi, 'WhoWasI';

frist_call();


sub frist_call {
    print 'caller() in LIST : ';
    print $_." " for caller;
    print "\n";

    say 'caller() in SCALAR : '.scalar caller;

    second_call();
}

sub second_call {
    print 'caller() in LIST : ';
    print $_." " for caller;
    print "\n";

    say 'caller() in SCALAR : '.scalar caller;

    print "caller(0) in second_call() :\n";
    print $_ ? $_." " : 'undef ' for caller(0);
    print "\n";
    print "caller(1) in second_call() :\n";
    print $_ ? $_." " : 'undef ' for caller(1);
    print "\n";
    croak "$whowasi";
}

package WhoWasI;

use Carp;
use strict;
use warnings;
use 5.010;

sub TIESCALAR {return bless \my $whowasi, shift}
sub FETCH {return (caller(1))[3]."()"}