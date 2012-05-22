package Echelon;

use strict;
use warnings;
use 5.010;
use base qw(Girl);

our $VERSION = 0.0.1;
our @ISA = qw(Girl);

my $secret_room;
our $Master;

sub new {
    my $invocant = shift;
    my $class = ref $invocant || $invocant;
    my $self = {
        hair => "long",
        breast => "drop-shaped",
        virgin => 1,
        @_,
    };

    return bless $self, $class;
}

sub clone {
    my $model = shift;
    my $self = $model->new(%$model, @_);
    return $self;
}

sub snarl {
    my $self = shift;
    say "Snarling: @_";
    my %seen;
    for my $parent (@ISA) {
        if (my $code = $parent->can('snarl')) {
            $self->$code(@_) unless $seen{$code}++;
        }
    }
}

sub virgin : lvalue {
    my $self = shift;
    $self->{virgin};
}

sub Master : lvalue {
    $Master;
}

sub knock {
    my $self = shift;

    $self->$secret_room;
}

sub AUTOLOAD {
    my $self = shift;
    return if our $AUTOLOAD =~ /::DESTROY$/;

    say "I see $AUTOLOAD(@_), in $self";
}

$secret_room = sub {
    my $self = shift;

    say $self->{name}." in bedroom now!";
};

1;