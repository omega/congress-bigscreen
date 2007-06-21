package BigScreen::Schema::Delegate;

use strict;
use warnings;

use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/Core/);
__PACKAGE__->table('delegate');

__PACKAGE__->add_columns(
    'id'            => { data_type => 'INTEGER', is_auto_increment => 1 },
    'name'              => { data_type => 'varchar', is_nullable => 1, size => 128 },
    'nr'       => { data_type => 'integer', },
    'district'       => { data_type => 'integer', is_nullable => 1, },

);

__PACKAGE__->set_primary_key('id');


__PACKAGE__->add_unique_constraint('unique_name_group' => ['name', 'district']);
__PACKAGE__->belongs_to('district' => 'BigScreen::Schema::District');


sub pnr {
    my $self = shift;
    my $nr = $self->nr;
    
    return ("0"x(3 - length("$nr")) . $nr);
}
1;
