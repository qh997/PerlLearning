#!/usr/bin/env perl

frist(@ARGV);

sub frist {
    second(@_);
}

sub second {
    print $_."\n" for @_;
}