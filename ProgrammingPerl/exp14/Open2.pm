package Open2;

use Carp;
use 5.010;
use strict;
use warnings;
use IPC::Open2;
use Tie::Handle;

sub TIEHANDLE {
    my ($class, @cmd) = @_;
    say "$class, @cmd";
    no warnings 'once';
    my @fhpair = \do{local(*RDR, *WTR)};
    bless $_, 'Tie::StdHandle' for @fhpair;
    bless(\@fhpair => $class)->OPEN(@cmd) || die;
    return \@fhpair;
}

sub OPEN {
    my ($self, @cmd) = @_;
    say "$self, @cmd";
    $self->CLOSE if grep {defined} @{$self->FILENO};
    open2(@$self, @cmd);
}

sub FILENO {
    my $self = shift;
    [map {fileno $self->[$_]} 0, 1];
}

for my $outmeth (qw(PRINT PRINTF WRITE)) {
    no strict 'refs';
    *$outmeth = sub {
        my $self = shift;
        $self->[1]->$outmeth(@_);
    }
}

for my $inmeth (qw(READ READLINE GETC)) {
    no strict 'refs';
    *$inmeth = sub {
        my $self = shift;
        $self->[0]->$inmeth(@_);
    }
}

for my $doppelmeth (qw(BINMODE CLOSE EOF)) {
    no strict 'refs';
    *$doppelmeth = sub {
        my $self = shift;
        $self->[0]->$doppelmeth(@_) && $self->[1]->$doppelmeth(@_);
    }
}

for my $deadmeth (qw(SEEK TELL)) {
    no strict 'refs';
    *$deadmeth = sub {
        croak "can't $deadmeth a pipe";
    }
}

1;