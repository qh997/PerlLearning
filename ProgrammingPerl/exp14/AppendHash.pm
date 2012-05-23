package AppendHash;

use strict;
use warnings;
use 5.010;
use Tie::Hash;

our @ISA = ('Tie::StdHash');
sub STORE {
    my ($self, $key, $value) = @_;
    push @{$self->{$key}}, $value;
}

1;