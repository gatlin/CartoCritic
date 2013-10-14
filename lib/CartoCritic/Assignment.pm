package CartoCritic::Assignment;
use Mojo::Base 'Mojolicious::Controller';

use DateTime::Format::MySQL;
use DateTime;
use List::Util qw(shuffle);

sub for_class {
    my $self = shift;
    my $id = $self->param('id');
    my $user = $self->current_user;

    my $class = $user->teacher->classes->find($id);
    my @assignments = map {
        {
            id => $_->id,
            name => $_->name,
            due => DateTime::Format::MySQL->format_datetime($_->due),
            assigned => $_->assigned,
        }
    } $class->assignments;

    $self->render(json => \@assignments);
}

sub retrieve {
    my $self = shift;
    my $user = $self->current_user;
    my $id   = $self->param('id');
    my $assignment = $self->db->resultset('Assignment')->find($id);
    my $class = $assignment->class;

    $self->render(json => {
        id => $assignment->id,
        name => $assignment->name,
        due => DateTime::Format::MySQL->format_datetime($assignment->due),
        assigned => $assignment->assigned,
        class => {
            id => $class->id,
            title => $class->title,
            semester => $class->semester,
        },
    });
}

sub create {
    my $self = shift;
    my $user = $self->current_user;

    my $obj = Mojo::JSON->new->decode($self->req->body);
    my $class = $self->db->resultset('Class')->find($obj->{class_id});

    my $d = $obj->{due};
    chomp($d);

    my $r = $class->assignments->create({
        name => $obj->{name},
        due => DateTime::Format::MySQL->parse_datetime($d),
    });

    $self->render(json => $r);
}

sub remove {
    my $self = shift;
    my $user = $self->current_user;

    my $id   = $self->param('id');
    my $assignment = $self->db->resultset('Assignment')->find($id);
    $assignment->delete if $assignment;

    $self->render(json => {});
}

sub assign {
    my $self = shift;
    my $user = $self->current_user;

    my $id   = $self->param('id');
    my $assignment = $self->db->resultset('Assignment')->find($id);

    $self->render(json => {}) and return if $assignment->assigned == 1;

    my $class = $assignment->class;
    use Data::Dump qw(pp);
    my @students = shuffle(map { $_->student }
        $class->student_classes->all);

    my %maps = (); my %peers = ();
    my $i = 0; my $k = scalar(@students);

    # this is the worst algorithm
    while ($i < $k) {
        my $student = $students[$i];
        # take this student, assign him to grade the next 3 ahead
        $peers{$student->id} = [map {$students[($i+$_)%$k]->id} (1..3)];

        # construct a map entry for the student
        my $map = $self->db->resultset('Map')->create({
            student => $student,
            assignment => $assignment,
            created => DateTime->now(),
            updated => DateTime->now(),
            guid => $self->mkId,
        });
        $maps{$student->id} = $map;
        $i = $i + 1;
    }
    foreach my $student (@students) {
        foreach my $peer(@{$peers{$student->id}}) {
            my $map = $maps{$peer};
            my $c = $self->db->resultset('Critique')->create({
                map => $map,
                grader => $student,
                analysis => '',
                created => DateTime->now(),
                guid => $self->mkId,
            });
        }
    }
    $assignment->update({ assigned => 1 });
    say pp %peers;
    $self->render(json => {success => 1});
}

1;
