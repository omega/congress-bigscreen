package BigScreen::Controller::Root;

use strict;
use warnings;
use utf8;
use base 'Catalyst::Controller';

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config->{namespace} = '';

=head1 NAME

BigScreen::Controller::Root - Root Controller for BigScreen

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=cut

=head2 default

=cut

sub auto : Private {
    my ( $self, $c ) = @_;
    
    $c->stash->{'bodyid'} = 'frontend';
    
}
sub index : Private {
    my ( $self, $c ) = @_;

    # Hello World
    
}

=head2 end

Attempt to render a view, if needed.

=cut 

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Andreas Marienborg

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
