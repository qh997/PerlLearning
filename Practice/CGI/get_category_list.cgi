#!/usr/bin/perl

use warnings;
use strict;
use dbi;

print "content-type: text/html\n\n";
print join ',', dbi->get_category_list();