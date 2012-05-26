#!/usr/bin/env perl
# 第十七章 线程

use 5.010;
use strict;
use Thread 'async';
use warnings;

sub ps {say '-' x 45}

# 线程模型
## 线程模块
my $t1 = async {
    my @stuff1 = qw(xy jj ss lj gs);
    sleep 2;
    return @stuff1;
};

my $t2 = async {
    my $stuff2 = 'I have an apple!';
    return $stuff2;
};

say $t1->tid();
say $t2->tid();

sleep 1;

my $retval = $t2->join();
print "2nd kid returned $retval\n";

my @retlist = $t1->join();
print "1st kid returned @retlist\n";
ps;

