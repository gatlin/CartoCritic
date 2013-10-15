package CartoCritic::Critique;
use Mojo::Base 'Mojolicious::Controller';

sub retrieve {
    my $self = shift;
    my $id   = $self->param('id');

    my $critique = $self->db->resultset('Critique')->find({ guid => $id });
    my $map = $critique->map;

    $self->render(json => {
        id => $map->guid,
        filename => $map->name,
        graded => $critique->graded,
        analysis => ($critique->analysis) ? $critique->analysis : '',
        score => $critique->score,
        assignment => {
            id => $map->assignment->id,
            name => $map->assignment->name,
            class => {
                id => $map->assignment->class->id,
                title => $map->assignment->class->title
            },
        },
    });
}

sub update {
    my $self = shift;
    my $id   = $self->param('id');

    my $obj = Mojo::JSON->new->decode($self->req->body);
    my $critique = $self->db->resultset('Critique')->find({ guid => $id });
    $critique->update({
        graded => 1,
        analysis => $obj->{analysis},
        score => $obj->{score},
    });

    $self->render(json => { success => 1 });
}

1;
