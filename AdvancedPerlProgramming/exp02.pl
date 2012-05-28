#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

sub ps {say '-' x 45}

# 例子：矩阵
my @matrix1 = (
    [1, 2, 3],
    [4, 5, 6],
    [5, 1, 0],
);
my @matrix2 = (
    [9, 9, 6],
    [2, 3, 0],
    [5, 8, 1],
);

my $ra_mm = matrix_multiply(\@matrix1, \@matrix2);
say "@$_" for @$ra_mm;

sub matrix_multiply {
    my ($r_mat1, $r_mat2) = @_;
    my $r_product;
    my ($r1, $c1) = matrix_count_rows_cols($r_mat1);
    my ($r2, $c2) = matrix_count_rows_cols($r_mat2);
    die "Wrong!" if $r1 != $c2;

    for (my $i = 0; $i < $r1; $i++) {
        for (my $j = 0; $j < $c2; $j++) {
            my $sum = 0;
            for (my $k = 0; $k < $c1; $k++) {
                $sum += $r_mat1->[$i][$k] * $r_mat2->[$k][$j]
            }
            $r_product->[$i][$j] = $sum;
        }
    }

    return $r_product;
}

sub matrix_count_rows_cols {
    my $r_mat = shift;
    return (scalar(@$r_mat), scalar(@{$r_mat->[0]}));
}
ps;

# vec
my $bitstring = '';
my $offset = 0;

foreach my $num (0, 5, 5, 6, 2, 7, 12, 6) {
    vec($bitstring, $offset++, 4) = $num;
}
say '$bitstring = '.$bitstring;
say 'Length of $bitstring: '.length($bitstring);

foreach my $offset (0..(length($bitstring) * 2)) {
    say vec($bitstring, $offset, 4);
}
say unpack("h*", $bitstring);
say unpack("b*", $bitstring);
say $bitstring;
say vec($bitstring, 18, 1);
ps;

require 'dumpvar.pl';
dumpValue(\@matrix2);