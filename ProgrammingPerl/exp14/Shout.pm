package Shout;

use Carp;
use strict;
#use warnings;
use 5.010;
use overload '""' => sub {$_[0]->pathname};

sub trace {
    my $self = shift;
    local $Carp::CarpLevel = 1;
    Carp::cluck("\ntrace magical method") if $self->debug;
}

sub pathname {
    my $self = shift;
    confess "i am not a class method" unless ref $self;
    $$self->{PATHNAME} = shift if @_;
    return $$self->{PATHNAME};
}

sub debug {
    my $self = shift;
    my $var = ref$self ? \$$self->{DEBUG} : \our $Debug;
    $$var = shift if @_;
    return ref $self ? $$self->{DEBUG} || $Debug : $Debug;
}

sub TIEHANDLE {
    my $class = shift;
    my $form = shift;
    my $name = "$form@_";
    open my $self, $form, @_
        or croak "can't open $form@_: $!";
    if ($form =~ />/) {
        print $self "<SHOUT>\n";
        $$self->{WRITING} = 1;
    }
    bless $self, $class;
    $self->pathname($name);
    return $self;
}

sub PRINT {
    my $self = shift;
    print $self map {uc} @_;
}

sub READLINE {
    my $self = shift;
    return <$self>;
}

sub GETC {
    my $self = shift;
    $self->trace;
    return getc($self);
}

sub OPEN {
    my $self = shift;
    my $form = shift;
    my $name = "$form@_";
    $self->CLOSE;
    open $self, $form, @_
        or croak "can't open $form@_: $!";
    $self->pathname($name);
    if ($form =~ />/) {
        print $self "<SHOUT>\n";
        $$self->{WRITING} = 1;
    }
    else {
        $$self->{WRITING} = 0;
    }
    return 1;
}

sub CLOSE {
    my $self = shift;
    if ($$self->{WRITING}) {
        $self->SEEK(0, 2) or return;
        $self->PRINT("</SHOUT>\n") or return;
    }
    return close $self;
}

sub SEEK {
    my $self = shift;
    $self->trace;
    my ($offset, $whence) = @_;
    return seek($self, $offset, $whence);
}

sub TELL {
    my $self = shift;
    return tell $self;
}

sub PRINTF {
    my $self = shift;
    my $templete = shift;
    return $self->PRINT(sprintf $templete, @_);
}

sub READ {
    my ($self, undef, $length, $offset) = @_;
    my $bufref = \$_[1];
    return read($self, $$bufref, $length, $offset);
}

sub WRITE {
    my $self = shift;
    my $string = uc(shift);
    my $length = shift || length $string;
    my $offset = shift || 0;
    return syswrite($self, $string, $length, $offset);
}

sub EOF {
    my $self = shift;
    return eof $self;
}

=del
sub BINMODE {
    my $self = shift;
    my $disc = shift || ":raw";
    return binmode($self, $disc);
}
=cut

sub BINMODE {croak "Too late to use binmode"}

sub FILENO {
    my $self = shift;
    return fileno $self;
}

sub DESTROY {
    my $self = shift;
    $self->CLOSE;
}

1;