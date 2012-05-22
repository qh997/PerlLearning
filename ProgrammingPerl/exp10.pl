#!/usr/bin/env perl

use 5.010;
sub ps {say '-' x 45};

say "__PACKAGE__ = ".__PACKAGE__;
ps;

$foo = 'LL';
foreach my $symname (sort keys %main::) {
    local *sym = $main::{$symname};
    say "\$$symname is defined" if defined $sym;
    say "\@$symname is nonnull" if @sym;
    say "\%$symname is nonnull" if %sym;
}
ps;

${'!@#$%'} = 2;
say "\${'!\@#\$\%'} = ".${'!@#$%'};
ps;

$richard = 'PPP';
*dick = \$richard;
say '$dick = '.$dick;
$dick = 'SSS';
say '$dick = '.$dick;
ps;

*units = populate();
say '$units{kg} = '.$units{kg};

sub populate {
    my %newhash = (km => 10, kg => 70);
    return \%newhash;
}
ps;

%units = (mile => 6, stones => 11);
fillerup(\%units);
say '$units{quarts} = '.$units{quarts};
say '$units{mile} = '.$units{mile};
sub fillerup {
    local *hashsym = shift;
    $hashsym{quarts} = 4;
    $hashsym{mile} = 3;
}
ps;

*PI = \3.14159265358979323;
*PI = [a, b, c, d];
say '$PI = '.$PI;
say '@PI = '.@PI;
ps;

{
    package inside;

    say __PACKAGE__;
    *PI = \@main::PI;
    *PI = \$main::PI;
    say @PI;
    say $PI;

    $foobar = '007';
}

*fb = *inside::foobar;
say $fb;
ps;

my $sym = 'richard';
say ${$sym};
say ${$main::{'richard'}};
say ${$inside::{"foobar"}};
