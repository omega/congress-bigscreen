package BigScreen::Controller::Ajax;

use strict;
use warnings;
use base 'Catalyst::Controller';

=head1 NAME

BigScreen::Controller::Ajax - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index 

=cut

use JSON;

sub update : Local {
    my ( $self, $c ) = @_;
    my $r = {
        'speaker' => $c->forward('speaker'),
        'next_speaker' => $c->forward('next_speaker'),
        'agenda' => $c->forward('agenda'),
    };
    $c->stash->{res} = $r;
}

sub speaker : Private {
    my ( $self, $c ) = @_;
    
    my $speaker = $c->model('Base::SpeechList')->find({ done => 0, pulled => 0}, {order_by => 'id'});
    
    my $response = {};
    if ($speaker) {
        $response->{nr} = $speaker->delegate->pnr;
        $response->{name} = $speaker->delegate->name;
        $response->{district} = $speaker->delegate->district->name;
    }
    return $response;
}

sub next_speaker : Private {
    my ( $self, $c ) = @_;
    
    my $speakers = $c->model('Base::SpeechList')->search({ done => 0, pulled => 0}, {order_by => 'id'});
    my $speaker = $speakers->next;
    
    my $response = {};
    if ($speaker and $speaker = $speakers->next) {
        $response->{nr} = $speaker->delegate->pnr;
        $response->{name} = $speaker->delegate->name;
        $response->{district} = $speaker->delegate->district->name;
    }
    return $response;
}

sub agenda : Private {
    my ( $self, $c ) = @_;
    
    my $agenda = $c->model('Base::Agenda')->find({active => 1});
    
    my $response = {};
    if ($agenda) {
        $response->{nr} = $agenda->agendanr;
        $response->{title} = $agenda->title;
        $response->{subcase} = $agenda->subcase;
    }
    return $response;

}




sub end : Private {
    my ( $self, $c ) = @_;
    
    my $res = $c->stash->{res};
    
    $c->res->body(objToJson($res));
    
}
=head1 AUTHOR

Andreas Marienborg

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
