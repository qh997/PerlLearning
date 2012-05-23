package Girl;

use strict;
use warnings;
use 5.010;

use overload
    '""' => \&as_string,
    '++' => \&one_yesr,
    '<>' => \&line_by_line,
;

sub new {
    my $class = ref $_[0] || shift;

    my $data = {
        NAME   => "unknown",
        AGE    => "unknown",
        HAIR   => "unknown",
        BREAST => "unknown",
        VIRGIN => "unknown",
    };

    my $self = sub : lvalue {
        my $field = shift;
        $data->{$field};
    };

    return bless $self, $class;
}

sub as_string {
    my $self = shift;

    return "My name is ".$self->name
          ."and i'am ".$self->age." years old.\n"
          ."My hair is ".$self->hair."."
          ."I have ".$self->breast." chest!";
}

sub one_yesr {
    my $self = shift;

    return ++$self->age;
}

sub line_by_line {
    my $self = shift;

    $self->('LINES') = [$self->breast, $self->virgin]
        unless $self->('LINES');

    return shift @{$self->('LINES')};
}

for my $field (qw(name age hair breast virgin)) {
    no strict 'refs';
    *$field = sub : lvalue {
        my $self = shift;
        $self->(uc $field);
    }
}

1;