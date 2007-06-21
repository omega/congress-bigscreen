package BigScreen::Model::Base;

use strict;
use base 'Catalyst::Model::DBIC::Schema';

use BigScreen::Schema;

my $cfg = BigScreen->config->{db};

__PACKAGE__->config(
    schema_class => 'BigScreen::Schema',
    connect_info => [
        $cfg->{'dsn'},
        $cfg->{'user'},
        $cfg->{'password'},
        {AutoCommit => 1}
    ],

);


1;
