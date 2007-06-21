package BigScreen::Schema::District;

use strict;
use warnings;

use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/Core/);
__PACKAGE__->table('disctict');

__PACKAGE__->add_columns(
    'id'            => { data_type => 'INTEGER', is_auto_increment => 1 },
    'name'              => { data_type => 'varchar', is_nullable => 1, size => 64 },

);

__PACKAGE__->set_primary_key('id');

__PACKAGE__->has_many('delegates' => 'BigScreen::Schema::Delegate', 'district');

1;
