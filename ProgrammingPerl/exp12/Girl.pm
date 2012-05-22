package Girl;

use strict;
use warnings;
use 5.010;

sub adoption {
    my $invocant = shift;
    my $class = ref $invocant || $invocant;
    my $self = {@_};

    bless($self, $class);
    return $self;
}

sub move {
    my $self = shift;

    say $self->{name}.' moving...';
    say $self->{name}.' stop';
}

sub snarl {
    my $self = shift;

    say "$self snarl...@_";
}

sub name {
    my $self = shift;
    my $field = __PACKAGE__.'::name';
    if (@_) {$self->{field} = shift}
    return $self->{field};
}

1;