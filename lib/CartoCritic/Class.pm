package CartoCritic::Class;
use Mojo::Base 'Mojolicious::Controller';

sub list {
    my $self = shift;
    my $user = $self->current_user;

    my @classes = map {
        {
            title => $_->title,
            semester => $_->semester,
            id => $_->id,
        }
    } $user->teacher->classes->all;
    $self->render(json => \@classes);
}

sub retrieve {
    my $self = shift;
    my $id = $self->param('id');

    my $c;

    my $user = $self->current_user;
    $c = $user->teacher->classes->find($id);
    $self->render(json => '', status => 404)
        unless $c;

    $self->render(json => {
        title => $c->title,
        semester => $c->semester,
    });
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

    $self->render(json => $r);
}

sub update {
    my $self = shift;
    my $user = $self->current_user;
    my $id   = $self->param('id');

    my $n = Mojo::JSON->new->decode($self->req->body);
    my $o = $user->teacher->classes->find($id) // undef;

    $self->render(status => 404)
        unless $o;

    my $r = $o->update($n);
    $self->render(json => {
        title => $r->title,
        semester => $r->semester,
    });
}

sub remove {
    my $self = shift;
    my $user = $self->current_user;
    my $id   = $self->param('id');

    my $c = $user->teacher->classes->find($id) // undef;
    $c->delete if $c;

    $self->render(json => {});
}

1;
