#!/usr/bin/env perl
# 第十一章 Perl 模块

use 5.010;
use File::Basename qw();
use File::Spec;

my $name = $0;
my $basename = File::Basename::basename $name;
my $dirname = File::Basename::dirname $name;
say "Basename = $basename";
say "Dirname  = $dirname";

my $new_name = File::Spec -> catfile($dirname, $basename);
say $new_name;