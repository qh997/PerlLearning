#!/usr/bin/perl

use warnings;
use strict;
use dbi;
use CGI;

my $query = new CGI;

print "content-type: text/html\n\n";
print join ',', dbi->get_buildnumber_list($query->param('platform'));