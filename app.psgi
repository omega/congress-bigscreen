#!/usr/bin/env perl
use strict;
use warnings;
use lib 'lib';
use BigScreen;

my $app = BigScreen->apply_default_middlewares(BigScreen->psgi_app(@_));