#!/usr/bin/perl

use warnings;
use strict;
use dbi;
use CGI;

my $query = new CGI;

print "content-type: text/html\n\n";
print join ',', dbi->get_testcase_list(
    $query->param('platform'),
    $query->param('buildnum'),
    $query->param('category'),);