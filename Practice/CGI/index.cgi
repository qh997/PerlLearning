#!/usr/bin/perl

use warnings;
use strict;
use 5.010;
use CGI;

my $query = new CGI;

print
    $query->header,
    $query->start_html('hello world'),
    $query->h1('hello world'),
    $query->start_form,
    "What's your name? ", $query->textfield('name'), $query->p,
    "What's the combination?",
    $query->checkbox_group(
        -name=>'words',
        -values=>['eenie','meenie','minie','moe'],
        -defaults=>['eenie','moe']), $query->p,
    "What's your favorite color?",
    $query->popup_menu(
        -name=>'color',
        -values=>['red','green','blue','chartreuse']), $query->p,
    $query->submit,
    $query->end_form,
    $query->submit,
    $query->hr, "\n";

if ($query->param) {
    print
        "Your name is ", $query->em($query->param('name')), $query->p,
        "The keywords are: ", $query->em(join(", ", $query->param('words'))), $query->p,
        "Your favorite color is ", $query->em($query->param('color')), ".\n";
}

$query->end_html;