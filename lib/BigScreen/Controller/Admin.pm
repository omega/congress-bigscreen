package BigScreen::Controller::Admin;

use strict;
use warnings;
use base 'Catalyst::Controller';

=head1 NAME

BigScreen::Controller::Admin - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

sub auto : Private {
    my ( $self, $c ) = @_;
    
    $c->stash->{'bodyid'} = 'admin';
    
    $c->stash->{'delegates'} = $c->model('Base::Delegate')->search({}, { order_by => 'nr'});
    $c->stash->{'agenda'} = $c->model('Base::Agenda')->search({}, { order_by => 'agendanr, subcase'});
    $c->stash->{'speechlist'} = $c->model('Base::SpeechList')->search({ done => 0, pulled => 0}, {order_by => 'id'});
    $c->stash->{'districts'} = $c->model('Base::District')->search({}, { order_by => 'name' });
    
}


=head2 index 

=cut

sub index : Private {
    my ( $self, $c ) = @_;

}


sub delegate : Local {
    my ( $self, $c ) = @_;
    
    if ($c->req->method eq 'POST') {
        if ($c->req->param('name')) {
            my $d = $c->model('Base::Delegate')->find_or_create({
                nr => $c->req->param('nr'),
            });
            $d->name($c->req->param('name'));
            $d->district($c->req->param('district'));
            $d->update;
            
        } elsif (my $mass = $c->req->param('mass')) {
            my $del = $c->model('Base::Delegate');
            my $dis = $c->model('Base::District');
            
            my $sub = sub {
                map {
                    my ($nr, $name, $g2, $g1, $rest) = split(/[:;]/);
                    my $g = $g1 ? $g1 : $g2;
                     
                    $g =~ s/\s+\(\d+\)|(krets|krins)//g;
                    $g =~ s/^\s+//;
                    $g =~ s/\s+$//;
                    
                    my $gg = $dis->find_or_create({
                        name => $g,
                    });
                    my $d = $del->find_or_create({
                        nr => $nr
                    });
                    $d->name($name);
                    $d->district($gg->id);
                    $d->update();
                    
                } split(/\r\n/, $mass);
            };
            $c->model('Base')->schema->txn_do($sub);
            
        }
        
        $c->res->redirect('/admin/delegate');
    }
}


sub district : Local {
    my ( $self, $c ) = @_;
    
    if ($c->req->method eq 'POST' and my $name = $c->req->param('name')) {
        $c->model('Base::District')->find_or_create({
            name => $name,
        });
        $c->res->redirect('/admin/district');
    }
}

sub agenda : Local {
    my ( $self, $c ) = @_;
    
    if ($c->req->method eq 'POST' and my $agendanr = $c->req->param('agendanr')) {
        my $a = $c->model('Base::Agenda')->find_or_create({
            agendanr => $agendanr,
            subcase => $c->req->param('subcase'),
        });
        $a->title($c->req->param('title'));
        $a->update;
        
        $c->res->redirect('/admin/agenda');
    }
}

sub activate : Local {
    my ( $self, $c ) = @_;
    if (my $a = $c->req->param('a')) {
        my $old = $c->model('Base::Agenda')->search({active => '1'})->update({active => 0});
        
        $a = $c->model('Base::Agenda')->find($a);
        if ($a) {
            $a->active(1);
            $a->update;
        }
        
    }
    $c->res->redirect('/admin/');
}


sub speechlist : Local {
    my ( $self, $c ) = @_;
    if ($c->req->method eq 'POST' and my $nr = $c->req->param('nr')) {
        my $ag = $c->model('Base::Agenda')->find({active => 1});
        my $del = $c->model('Base::Delegate')->find({nr => $nr});
        if ($del) {
            $c->model('Base::SpeechList')->create({
                delegate => $del->id,
                done => 0,
                pulled => 0,
                agenda => $ag ? $ag->id : 0,
            });
        }
    }
    if (my $i = $c->req->param('d')) {
        $i = $c->model('Base::SpeechList')->find($i);
        if ($i) {
            $i->trekk(1);
            $i->update();
        }
    }
    if ($c->req->param('n')) {
        my $i = $c->model('Base::SpeechList')->find({ done => 0, pulled => 0}, {order_by => 'id'});
        if ($i) {
            $c->log->debug("Setting " . $i->id . " to done");
            $i->done(1);
            $c->log->debug("calling update");
            $i->update;
        }
    }
    $c->res->redirect($c->uri_for('/admin'));
}

=head1 AUTHOR

Andreas Marienborg

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
