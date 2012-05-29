#!/usr/bin/perl

use 5.010;
use strict;
use warnings;
use Environment;

#say $PATH;
#say $USER;

Environment::hello();
say HELPLIST;

foreach (keys %main::) {
    say;
}