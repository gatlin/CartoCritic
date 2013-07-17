package CartoCritic::User;
use Mojo::Base 'Mojolicious::Controller';

use Mojo::JSON::XS;

sub login {
    my $self = shift;
    my $u = $self->param('username');
    my $p = $self->param('password');

    say "WHAT THE FUCK IS GOING ON";
    say "USERNAME: $u";

    my $user = $self->db->resultset('User')->find(
        { username => $u },
        { key => "username" },
    );

    use Data::Dump qw(pp);
    say pp $user;

    if ($user) {
        say "WHAT";
        if ($self->authenticate($u,$p)) {
            $self->redirect_to('/app');
        }
        else {
            $self->redirect_to('/login');
        }
    }
    else {
        $self->redirect_to('/login');
    }
}

sub register {
    my $self = shift;
    my $u = $self->param('username');
    my $p = $self->param('password');
    my $e = $self->param('email');
    my $q = $self->param('password_again');

    my $h = $self->encrypt($p);

    $self->redirect_to('/register') and say "passwords don't match"
        and return 0
        unless $p eq $q;

    my $id = $self->mkId;
    my $user = $self->db->resultset('User')->find(
        { username => $u }
    );
    $self->redirect_to('/register') if $user;

    my $r = $self->db->resultset('User')->create({
        username => $u,
        password => $h,
        email    => $e,
    });

    $self->redirect_to('/login');
}

sub check {
    my $self = shift;
    say "CHECKING AUTHENTICATION";
    $self->redirect_to('/login') and return 0
        unless($self->is_user_authenticated);
    return 1;
}

sub logout_user {
    my $self = shift;
    $self->logout;
    $self->redirect_to('/login');
}

1;
