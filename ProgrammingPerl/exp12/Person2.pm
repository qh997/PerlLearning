package Person2;

use strict;
use warnings;
use 5.010;

sub new {
    my $class = ref $_[0] || shift;

    my $data = {
        NAME => "unnamed",
        RACE => "unknown",
        ALIASES => [],
    };

    my $self = sub {
        use Carp;

        local $Carp::CarpLevel = 1;
        my ($cpack, $cfile) = caller;

        my $field = shift;

        croak "No valid field '$field' in object"
            unless exists $data->{$field};

        $data->{$field} = shift if @_;
        return $data->{$field};
    };

    return bless $self, $class;
}

for my $field (qw(name race aliases)) {
    no strict 'refs';
    *$field = sub {
        my $self = shift;
        return $self->(uc $field, @_);
    }
}

1;