package CartoCritic::Student;
use Mojo::Base 'Mojolicious::Controller';

sub list {
    my $self = shift;
    my $user = $self->current_user;

    $self->render(json => '', status => 403)
        unless $user->role eq 'teacher';

    my @students = $self->db->resultset('Student')->all;
    $self->render(json => \@students);
}

sub retrieve {
    my $self = shift;
    my $user = $self->current_user;
    my $id   = $self->params('id');

    my $s;
    if ($user->role eq 'teacher'
    || ($user->role eq 'student'
    &&  $user->id   eq $id)) {
        $s = $self->db->resultset('Student')->find(
            { id => $id }
        );

        $self->render(json => $s);
    }
    else {
        $self->render(json => '', status => 403);
    }
}

sub create {
    my $self = shift;
    my $user = $self->current_users;

    my $obj = Mojo::JSON->new->decode($self->req->body);

    my $r = $user->student->create({
        name => $obj->{name},
    });

    $self->render(json => $r, status => 201);
}

sub update {
    my $self = shift;
    my $user = $self->current_users;
    my $id   = $self->params('id');

    my $n = Mojo::JSON->new->decode($self->req->body);
    my $o = $user->student;

    $self->render(json => '', status => 404)
        unless $o;

    $r = $o->update($n);
    $self->render(json => $r);
}

sub remove {
    my $self = shift;
    my $user = $self->current_users;
    my $id   = $self->params('id');


}

sub grades {
    my $self = shift;
}
