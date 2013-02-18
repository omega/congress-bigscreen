#!/usr/bin/env perl
use strict;
use warnings;
use lib 'lib';
use BigScreen;
BigScreen->setup_engine('PSGI');;
my $app = sub { BigScreen->run(@_) };
