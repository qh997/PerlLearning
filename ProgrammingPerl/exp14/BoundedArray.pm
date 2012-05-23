package BoundedArray;

use Carp;
use strict;
use Tie::Array;
use 5.010;

our @ISA = ('Tie::Array');

sub TIEARRAY {
    my $class = shift;
    my $bound = shift;
    confess "usage: tie(\@ary, 'BoundedArray', max_subscript)"
        if @_ || $bound =~ /\D/;
    return bless {BOUND => --$bound, DATA => []}, $class;
}

sub FETCH {
    my ($self, $index) = @_;
    if ($index > $self->{BOUND}) {
        confess "Array OOB: $index > $self->{BOUND}";
    }
    return $self->{DATA}[$index];
}

sub STORE {
    my ($self, $index, $value) = @_;
    if ($index > $self->{BOUND}) {
        confess "Array OOB: $index > $self->{BOUND}";
    }
    return $self->{DATA}[$index] = $value;
}

sub FETCHSIZE {
    my $self = shift;
    return scalar @{$self->{DATA}};
}

sub STORESIZE {
    my ($self, $count) = @_;
    if ($count > $self->{BOUND}) {
        confess "Array OOB: $count > $self->{BOUND}";
    }
    return $#{$self->{DATA}} = $count;
}

sub EXISTS {
    my ($self, $index) = @_;
    if ($index > $self->{BOUND}) {
        confess "Array OOB: $index > $self->{BOUND}";
    }
    return exists $self->{DATA}[$index];
}

sub DELETE {
    my ($self, $index) = @_;
    if ($index > $self->{BOUND}) {
        confess "Array OOB: $index > $self->{BOUND}";
    }
    delete $self->{DATA}[$index];
}

sub CLEAR {
    my $self = shift;
    $self->{DATA} = [];
}

sub PUSH {
    my $self = shift;
    if (@_ + $#{$self->{DATA}} > $self->{BOUND}) {
        confess "Attempt to push too many elements";
    }
    push @{$self->{DATA}}, @_;
}

sub UNSHIFT {
    my $self = shift;
    if (@_ + $#{$self->{DATA}} > $self->{BOUND}) {
        confess "Attempt to push too many elements";
    }
    unshift @{$self->{DATA}}, @_;
}

sub POP {
    my $self = shift;
    return pop @{$self->{DATA}};
}

sub SHIFT {
    my $self = shift;
    return shift @{$self->{DATA}};
}

1;