#!/usr/bin/env perl

use 5.010;

frist(<>);

sub frist {
    print "this @_\n";
    second(@_);
}

sub second {
    print $_."\n" for @_;
}

@ARGV = qw(sss);
while (<>) {
    chomp;
    print "It was $_\n";
}

@ARGV = qw(sss);
print <>, "\n";

@array = qw(123 321 222 111 444);
print "@array\n";

print "Oops! (2+3)*4 = ";
print (2+3)*4;
print "\n";

$user = "gengs";
$days_to_die = '22';
printf "Hello, %s;your password expires in %d days!\n",
    $user, $days_to_die;

printf "%6d%%\n", 42;
printf "%g %g %g %g\n", 5/2, 51/17, 51**17, $user;

my @items = qw(wilma dino pebbles);
my $format = "The items are:\n".("%10s\n" x @items);
printf $format, @items;