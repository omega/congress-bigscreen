use inc::Module::Install;

name 'BigScreen';
all_from 'lib/BigScreen.pm';

requires 'Catalyst' => '5.7006';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'YAML'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats

requires 'Catalyst::Engine::PSGI';
requires 'DBIx::Class';
requires 'Catalyst::Model::DBIC::Schema';
requires 'Catalyst::View::TT';
requires 'JSON';
requires 'Plack';


catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
