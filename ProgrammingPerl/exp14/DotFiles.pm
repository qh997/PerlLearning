package DotFiles;

use Carp;
use strict;
use warnings;

my $DEBUG = 0;

sub whowasi {(caller(1))[3]."()"}
sub debug {$DEBUG = @_ ? shift : 1}

sub TIEHASH {
    my $self = shift;
    my $user = shift || $>;
    my $dotdir = shift || "";

    croak "usage: @{[&whowasi]} [USER [DOTDIR]]" if @_;

    $user = getpwuid($user) if $user =~ /^\d+$/;
    my $dir = (getpwnam($user))[7]
        or croak "@{[&whowasi]}: no user $user";
    $dir .= "/$dotdir" if $dotdir;

    my $node = {
        USER => $user,
        HOME => $dir,
        
    }
}