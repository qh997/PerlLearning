package Person1;

use strict;
use warnings;
use 5.010;

sub new {
    my $invocant = shift;
    my $self = bless({}, ref $invocant || $invocant);
    $self->init();
    return $self;
}

sub init {
    my $self = shift;
    $self->name("unnamed");
    $self->race("unknown");
    $self->aliases([]);
}

for my $field (qw(name race aliases)) {
    my $slot = __PACKAGE__."::$field";
    no strict "refs";
    *$slot = sub {
        my $self = shift;
        $self->{$field} = shift if @_;
        return $self->{$field};
    }
}

1;