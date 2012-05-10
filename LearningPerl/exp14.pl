#!/usr/bin/env perl

use 5.010;

# 在字符串内用 index 搜索
my $stuff = "Howdy world!";
my $where = index($stuff, "wor");
say $where;

my $where1 = index($stuff, "w");
my $where2 = index($stuff, "w", $where1 + 1);
my $where3 = index($stuff, "w", $where2 + 1);
say "$where1, $where2, $where3";

say my $last_slash = rindex("/etc/passwd", "/");