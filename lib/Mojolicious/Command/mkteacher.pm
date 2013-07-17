package Mojolicious::Command::mkteacher;
use Mojo::Base 'Mojolicious::Command';

use Term::ReadPassword;

has description => "Create a teacher user\n";
has usage => "usage: $0 mkteacher [USERNAME]\n";

sub run {
    my ($self) = @_;
    print "Name: ";
    my $realname = <STDIN>;
    chomp($realname);
    print "Username: ";
    my $username = <STDIN>;
    chomp($username);
    print "Email: ";
    my $email = <STDIN>;
    chomp($email);

    my $p1;
    my $p2;
    while (1) {
        $p1 = read_password("Password: ");
        $p2 = read_password("Again: ");
        last if $p1 eq $p2;
    }
    chomp($p1);
    my $ur = $self->app->db->resultset('User')->create({
        username => $username,
        email => $email,
        password => $self->app->encrypt($p1),
        role => "teacher",
    });

    my $tr = $self->app->db->resultset('Teacher')->create({
        name => $realname,
        user => $ur,
    });

    say "Created teacher ", $tr->id;
}

1;
