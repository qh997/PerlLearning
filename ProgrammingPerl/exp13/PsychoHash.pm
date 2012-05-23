package PsychoHash;

use 5.010;
use overload
    'fallback' => '1',
    '%{}' => \&as_hash,
;

sub as_hash {
    my $x = shift;
    return {@$x};
}

sub new {
    my $class = shift;
    return bless [@_] => $class;
}

1;