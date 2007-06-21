package BigScreen::Schema::SpeechList;

use strict;
use warnings;

use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/Core/);
__PACKAGE__->table('speechlist');

__PACKAGE__->add_columns(
    'id'            => { data_type => 'INTEGER', is_auto_increment => 1 },
    'delegate'       => { data_type => 'integer', is_nullable => 0, },
    'done'       => { data_type => 'boolean',  is_nullable => 1, default_value => 'f', },
    'pulled'       => { data_type => 'boolean', is_nullable => 1, default_value => 'f', },
    'agenda'       => { data_type => 'integer', is_nullable => 0, },
    
);

__PACKAGE__->set_primary_key('id');


__PACKAGE__->belongs_to('agenda' => 'BigScreen::Schema::Agenda');
__PACKAGE__->belongs_to('delegate' => 'BigScreen::Schema::Delegate');

1;
