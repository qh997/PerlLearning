#!/usr/bin/env perl

use 5.010;

frist(<>);

sub frist {
    print "These are :\n@_\n";
    second(@_);
}

sub second {
    print $_ for @_;
}
print "\n";

@ARGV = qw(text01);
while (<>) {
    chomp;
    print "It was $_\n";
}

@ARGV = qw(text01);
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

1 && warn "I am dead.";
1 && warn "$0 : I am dead.\n";

print '__FILE__ = ', __FILE__, "\n";
print '__LINE__ = ', __LINE__, "\n";

#($package, $filename, $line) = caller;
#print "$package, $filename, $line\n";

say "Hello!";
say $user;