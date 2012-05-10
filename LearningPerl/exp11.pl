#!/usr/bin/env perl

use 5.010;
use File::Basename qw();

my $name = "/usr/local/bin/perl";
my $basename = File::Basename::basename $name;
my $dirname = File::Basename::dirname $name;
say "Basename = $basename";
say "Dirname  = $dirname";