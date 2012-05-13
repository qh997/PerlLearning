#!/usr/bin/env perl
# 第七章 漫游正则表达式王国

use 5.010;

$_ = "yabba dabba boo";
if (/abba/) {
    print "It matched!\n";
}

$_ = "abba";
if (/(.)\1/) {
    print "It matched the same char next to itself!\n";
}

$_ = "aa11bb";
if (/(.)\g{-1}11/) {
    print "It matched!\n";
}

# \w = [a-zA-Z0-9_]
# \s = [\f\t\n\r ]
# \h = [\t ]
# \v = [\f\n\r]
# \R 任何断行
# [\d\D] 任何字符（包括还行符）

