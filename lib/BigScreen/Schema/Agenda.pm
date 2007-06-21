package BigScreen::Schema::Agenda;

use strict;
use warnings;

use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/Core/);
__PACKAGE__->table('agenda');

__PACKAGE__->add_columns(
    'id'            => { data_type => 'INTEGER', is_auto_increment => 1 },
    'agendanr'       => { data_type => 'varchar', size => 12, },
    'subcase'       => { data_type => 'varchar', size => 12, is_nullable => 0, },
    'title'       => { data_type => 'varchar', size => 128, is_nullable => 1, },
    'active'       => { data_type => 'integer', size => 1, is_nullable => 0, default_value => '0' },
);

__PACKAGE__->set_primary_key('id');


__PACKAGE__->has_many('speeches' => 'BigScreen::Schema::SpeechList', 'agenda');

1;
