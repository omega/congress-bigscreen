use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'BigScreen' }
BEGIN { use_ok 'BigScreen::Controller::Admin' }

ok( request('/admin')->is_success, 'Request should succeed' );


