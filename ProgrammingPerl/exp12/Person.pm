package Person;

use strict;
use warnings;
use 5.010;
use fields qw(name race aliases);

sub new {
    my $type = shift;
    my $self = fields::new(ref $type || $type);
    $self->{name} = "unnamed";
    $self->{race} = "unknown";
    $self->{aliases} = [];
    return $self;
}

sub name {
    my $self = shift;
    $self->{name} = shift if @_;
    return $self->{name};
}

1;