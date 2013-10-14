package CartoCritic::Student;
use Mojo::Base 'Mojolicious::Controller';

sub for_class {
    my $self = shift;
    my $user = $self->current_user;
    my $id   = $self->param('id');
    my $class = $user->teacher->classes->find($id);
    my @students = map {
        {
            id => $_->student->id,
            fname => $_->student->fname,
            lname => $_->student->lname,
            email => $_->student->email,
        }
    } $class->student_classes->all;

    $self->render(json => \@students);
}

sub for_assignment {
    my $self = shift;
    my $user = $self->current_user;
    my $id   = $self->param('id');
    my $a = $self->db->resultset('Assignment')->find($id);
    my $class = $a->class;
    my @students = map {
        my @maps = $a->search_related('maps', { student_id => $_->student->id });
        use Data::Dump qw(pp);
        {
            id => $_->student->id,
            fname => $_->student->fname,
            lname => $_->student->lname,
            submitted => ($maps[0] && $maps[0]->submitted) ? \1 : \0,
            peers_done => 0,
            link => ($maps[0]) ? $maps[0]->guid : '',
        }
    } $class->student_classes->all;

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
    my $user = $self->current_user;

    my $obj = Mojo::JSON->new->decode($self->req->body);
    my $class = $self->db->resultset('Class')->find($obj->{class});

    my $r = $self->db->resultset('Student')->create({
        fname => $obj->{fname},
        lname => $obj->{lname},
        email => $obj->{email},
    });

    $self->db->resultset('StudentClass')->create({
        student => $r,
        class   => $class,
    });

    $self->render(json => $r);
}

sub update {
    my $self = shift;
    my $user = $self->current_user;
    my $id   = $self->params('id');

    my $n = Mojo::JSON->new->decode($self->req->body);
    my $o = $user->student;

    $self->render(json => '', status => 404)
        unless $o;

    my $r = $o->update($n);
    $self->render(json => $r);
}

sub remove {
    my $self = shift;
    my $user = $self->current_user;
    my $id   = $self->param('id');

    my $student = $self->db->resultset('Student')->find($id);
    my @scs = $student->student_classes->all;
    foreach my $sc (@scs) {
        $sc->delete if $sc;
    }
    $student->delete if $student;

    $self->render(json => {});
}

sub grades {
    my $self = shift;
}

1;
