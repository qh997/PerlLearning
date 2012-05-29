package Environment;

use 5.010;
use strict;
use warnings;

our $HELPLIST = <<END;
    (a) Change account
    (s) Register or change password
    (g) Use guide to set information (Recommend)
    (i) Information edition command
    (p) Print your informations
    (h) Show this help list
    (q) Quit
END

sub import {
    my $caller = caller;
    no strict 'refs';
    foreach (keys %ENV) {
#        *{"${caller}::$_"} = \$ENV{$_};
    }
}

sub AUTOLOAD {
    our $AUTOLOAD;
    say "$AUTOLOAD(@_)";
}

foreach my $field (qw(HELPLIST)) {
    no strict 'refs';

    my $slot = __PACKAGE__."::$field";
    $slot = sub {
        return $$field;
    };

    my $caller = caller;
    *{"${caller}::$field"} = \&$slot;
}

1;