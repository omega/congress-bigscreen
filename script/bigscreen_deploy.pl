#!/usr/bin/perl

use strict;
use warnings;

use FindBin;

use lib "$FindBin::Bin/../lib";

use BigScreen;
use BigScreen::Schema;

my $cfg = BigScreen->config->{db};

my $schema = BigScreen::Schema->connect($cfg->{dsn});
$schema->deploy;

