#!/usr/bin/perl

use warnings;
use strict;
use 5.010;
use CGI;

close STDIN;

my $qy = new CGI;
my $resp = '';

$resp .= $qy->header;
$resp .= $qy->start_html(
    -title => 'Auto Test',
    -head => [
#        $qy->Link({-type => 'text/css', -rel => 'stylesheet', -href => 'http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css'}),
        $qy->Link({-type => 'text/css', -rel => 'stylesheet', -href => 'static/katf.css'}),
    ],
    -script => {-type => 'text/javascript', -src => 'static/katf.js'},
);

$resp .= $qy->start_div({-id => 'wrap'});

$resp .= $qy->start_div({-id => 'header'});
$resp .= $qy->h1('Auto Test');
$resp .= $qy->end_div;

$resp .= $qy->start_div({-id => 'nav'});
$resp .= $qy->hr;
$resp .= $qy->start_form;
$resp .= $qy->start_div({-id => 'd_condition', -name => 'd_condition'});
$resp .= $qy->start_table({-class => 'condition'});

$resp .= $qy->Tr($qy->td($qy->b('platform:')), $qy->td($qy->Select({
    -name => 'platform',
    -id => 'platform',
    -style => 'width:200px',
    -onChange => "platform_changed();",})));
$resp .= $qy->Tr($qy->td($qy->b('Build Number:')), $qy->td($qy->Select({
    -name=>'build_number',
    -id=>'build_number',
    -style=>'width:200px',
    -onChange => "buildnumber_changed();",})));
$resp .= $qy->Tr($qy->td($qy->b('Category:')), $qy->td($qy->Select({
    -name=>'category',
    -id=>'category',
    -style=>'width:200px',
    -onChange => "category_changed();",})));
$resp .= $qy->Tr($qy->td($qy->b('Test Cases:')), $qy->td($qy->Select({
    -name=>'testcases',
    -id=>'testcases',
    -style=>'width:200px',
    -onChange => "testcase_changed();",})));

$resp .= $qy->end_table;
$resp .= $qy->end_div;
$resp .= $qy->start_div({-class => 'action'});
$resp .= $qy->input({-type => 'submit', value => 'Show'});
$resp .= '&nbsp;';
$resp .= $qy->input({-type => 'submit', value => 'Compare'});
$resp .= $qy->end_div;
$resp .= $qy->end_form;
$resp .= $qy->end_div;

$resp .= $qy->start_div({-id => 'main'});
$resp .= $qy->end_div;

if ($qy->param) {
    foreach ($qy->param) {
        $resp .= $qy->em($_);
        $resp .= $qy->p;
    }
}

$resp .= $qy->end_div;

$resp .= $qy->end_html;

print $resp, "\n";