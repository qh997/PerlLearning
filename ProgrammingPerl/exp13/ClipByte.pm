package ClipByte;

use strict;
use warnings;
use 5.010;

use overload 
    '+'  => \&clip_add,
    '-'  => \&clip_sub,
    '""' => \&as_string,
;

sub new {
    my $class = shift;
    my $value = shift;
    return bless \$value => $class;
}

sub clip_add {
    my ($x, $y) = @_;
    my $value = ref $x ? $$x : $x;
    $value   += ref $y ? $$y : $y;
    $value = 255 if $value > 255;
    $value = 0   if $value < 0;
    return bless \$value => ref $x;
}

sub clip_sub {
    my ($x, $y, $swap) = @_;
    my $value = ref $x ? $$x : $x;
    $value   -= ref $y ? $$y : $y;
    if ($swap) {$value = -$value}
    $value = 255 if $value > 255;
    $value = 0   if $value < 0;
    return bless \$value => ref $x;
}

sub as_string {
    return ${+shift};
}

1;