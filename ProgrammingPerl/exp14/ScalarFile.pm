package ScalarFile;

use Carp;
use strict;
use warnings;
use warnings::register;
my $count = 0;

sub TIESCALAR {
    my $class = shift;
    my $filename = shift;
    my $fh;
    if (open $fh, '<', $filename or
        open $fh, '>', $filename) {
        close $fh;
        $count++;
        return bless \$filename, $class;
    }
    else {
        carp "Can't tie $filename: $!" if warnings::enabled();
        return;
    }
}

sub FETCH {
    my $self = shift;
    confess "Not a class method" unless ref $self;
    open my $fh, $$self or return;
    read($fh, my $value, -s $fh);
    return $value;
}

sub STORE {
    my ($self, $value) = @_;
    ref $self
        or confess "Not a class method";
    open my $fh, '>', $$self
        or croak "Can't clobber $$self: $!";
    syswrite($fh, $value) == length $value
        or croak "Can't write to $$self: $!";
    close $fh
        or croak "Can't close $$self: $!";
    return $value;
}

sub DESTROY {
    my $self = shift;
    ref $self
        or confess "Not a class method";
    $count--;
}

sub count {
    $count;
}

1;