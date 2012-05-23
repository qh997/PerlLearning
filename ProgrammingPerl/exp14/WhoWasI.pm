package WhoWasI;

use Carp;
use strict;
use warnings;
use 5.010;

sub TIESCALAR {return bless \my $whowasi, shift}
sub FETCH {return (caller(1))[3]."()"}
1;