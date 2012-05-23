package DotFiles;

use Carp;
use strict;
use warnings;
use 5.010;
use WhoWasI;

my $DEBUG = 0;
tie my $whowasi, 'WhoWasI';

sub debug {$DEBUG = @_ ? shift : 1}
sub clobber {my $self = shift; $self->{CLOBBER} = @_ ? shift : 1;}

sub TIEHASH {
    my $self = shift;
    my $user = shift || $>;
    my $dotdir = shift || "";

    croak "usage: $whowasi [USER [DOTDIR]]" if @_;

    $user = getpwuid($user) if $user =~ /^\d+$/;
    my $dir = (getpwnam($user))[7]
        or croak "$whowasi: no user $user";
    $dir .= "/$dotdir" if $dotdir;

    my $node = {
        USER => $user,
        HOME => $dir,
        CONTENTS => {},
        CLOBBER => 0,
    };

    opendir DIR, $dir
        or croak "$whowasi: can't opendir $dir: $!";
    for my $dot (grep /^\./ && -f "$dir/$_", readdir(DIR)) {
        $dot =~ s/^\.//;
        $node->{CONTENTS}{$dot} = undef;
    }
    close DIR;

    return bless $node, $self;
}

sub FETCH {
    carp $whowasi if $DEBUG;
    my $self = shift;
    my $dot = shift;
    my $dir = $self->{HOME};
    my $file = "$dir/.$dot";

    unless (exists $self->{CONTENTS}{$dot} || -f $file) {
        carp "$whowasi: no $dot file" if $DEBUG;
        return undef;
    }

    if (defined $self->{CONTENTS}{$dot}) {
        return $self->{CONTENTS}{$dot};
    }
    else {
        return $self->{CONTENTS}{$dot} = `cat $file`;
    }
}

sub STORE {
    carp "$whowasi" if $DEBUG;
    my $self = shift;
    my $dot = shift;
    my $value = shift;
    my $file = $self->{HOME}."/.$dot";

    croak "$whowasi: $file not clobberable"
        unless $self->{CLOBBER};

    open(F, "> $file") or croak "can't open $file: $!";
    print F $value;
    close(F);
}

sub DELETE {
    carp "$whowasi" if $DEBUG;
    my $self = shift;
    my $dot = shift;
    my $file = $self->{HOME}."/.$dot";

    croak "$whowasi: won't remove file $file"
        unless $self->{CLOBBER};

    delete $self->{CONTENTS}{$dot};
    unlink $file or carp "$whowasi: can't unlink $file: $!";
}

sub CLEAR {
    carp "$whowasi" if $DEBUG;
    my $self = shift;
    croak "$whowasi: won't remove all dotfile for $self->{USER}"
        unless $self->{CLOBBER} > 1;
    for my $dot (keys %{$self->{CONTENTS}}) {
        $self->DELETE($dot);
    }
}

sub EXISTS {
    carp "$whowasi" if $DEBUG;
    my $self = shift;
    my $dot = shift;
    return exists $self->{CONTENTS}{$dot};
}

sub FIRSTKEY {
    carp "$whowasi" if $DEBUG;
    my $self = shift;
    my $temp = keys %{$self->{CONTENTS}};
    return scalar each %{$self->{CONTENTS}};
}

sub NEXTKEY {
    carp "$whowasi" if $DEBUG;
    my $self = shift;
    return scalar each %{$self->{CONTENTS}};
}

sub DESTORY {
    carp "$whowasi" if $DEBUG;
}

1;