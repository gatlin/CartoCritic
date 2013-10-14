package CartoCritic::Page;
use Mojo::Base 'Mojolicious::Controller';

sub index {
    my $self = shift;
    $self->render_static('index.html');
}

sub login {
    my $self = shift;
    $self->render_static('login.html');
}

sub register {
    my $self = shift;
    $self->render_static('register.html');
}

sub main {
    my $self = shift;
    $self->app->log->debug("in main app");
#    $self->render_static('app.html');
    $self->render_static('app.html');
}

1;
