package Bestiary;
require Exporter;

use 5.010;

our @ISA = qw(Exporter);
our @EXPORT = qw(camel);
our @EXPORT_OK = qw($weight);
our $VERSION = 1.00;

sub camel {say "One-hump dromedary"}

$weight = 1024;

1;