package CartoCritic::Class;
use Mojo::Base 'Mojolicious::Controller';

sub list {
    my $self = shift;

    my $user = $self->current_user;

    if ($user->role eq 'teacher') {
        my @classes = $user->teacher->classes;
        $self->render(json => \@classes);
    }
    else {
        my @classes = $user->student->classes;
        $self->render(json => \@classes);
    }
}

sub retrieve {
    my $self = shift;
    my $id = $self->param('id');

    my $c;

    my $user = $self->current_user;
    if ($user->role eq 'teacher') {
        $c = $user->teacher->classes->find($id);
        $self->render(json => '', status => 404)
            unless $c;
    }
    else {
        $c = $user->student->classes->find($id);
        $self->render(json => '', status => 404)
            unless $c;
    }

    $self->render(json => $c);
}

sub create {
    my $self = shift;
    my $user = $self->current_user;

    $self->render(json => '', status => 403)
        unless $user->role eq 'teacher';

    my $obj = Mojo::JSON->new->decode($self->req->body);
    my $teacher = $user->teacher;
    my $r = $teacher->classes->create({
        title => $obj->{title},
        semester => $obj->{semester},
        archived => 0,
    });

    $self->render(json => r);
}

sub update {
    my $self = shift;
    my $user = $self->current_user;
    my $id   = $self->params('id');

    $self->render(json => '', status => 403)
        unless $user->role eq 'teacher';

    my $n = Mojo::JSON->new->decode($self->req->body);
    my $o = $user->teacher->classes->find($id) // undef;

    $self->render(json => '', status => 404)
        unless $o;

    $r = $o->update($n);
    $self->render(json => $r);
}

sub remove {
    my $self = shift;
    my $user = $self->current_user;
    my $id   = $self->params('id');

    $self->render(json => '', status => 403)
        unless $user->role eq 'teacher';

    my $c = $user->teacher->classes->find($id) // undef;
    $c->delete if $c;

    $self->render(json => '', status => 204);
}

1;
