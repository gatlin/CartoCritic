package CartoCritic::Assignment;
use Mojo::Base 'Mojolicious::Controller';

use DateTime::Format::MySQL;
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

1;
