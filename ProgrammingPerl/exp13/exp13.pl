#!/usr/bin/env perl
# 重载

use strict;
use warnings;
use 5.010;

use ClipByte;
use Girl;
use PsychoHash;

sub ps {say '-' x 45}

my $byte1 = new ClipByte 200;
my $byte2 = new ClipByte 100;
say 6 + $byte1;
say 6 - $byte1;
say $byte1 - 6;

my $byte3 = $byte1 + $byte2;
$byte3 = $byte2 + $byte1;
say $byte3;
ps;

my $salve1 = Girl->new;
$salve1->name = 'changxy';
$salve1->age = '27';
$salve1->hair = 'long';
$salve1->breast = '37C';
$salve1->virgin = '1';
say $salve1;
ps;

$salve1++;
say $salve1;
ps;

while (<$salve1>) {
    say;
}
ps;

my $critter = new PsychoHash(height => 72, weight => 365, type => 'camel');
say $critter->{weight};
say $critter->[5];
say $critter;