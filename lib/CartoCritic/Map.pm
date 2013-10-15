package CartoCritic::Map;
use Mojo::Base 'Mojolicious::Controller';

sub retrieve {
    my $self = shift;
    my $user = $self->current_user;
    my $id   = $self->param('id');

    my $map = $self->db->resultset('Map')->find({ guid => $id });
    $self->render(json => {
        id => $map->id,
        submitted => $map->submitted,
        assignment => $map->assignment->id,
        student => $map->student->id,
        guid => $map->guid,
        name => $map->name,
    });
}

sub update {
    my $self = shift;
    my $user = $self->current_user;
    my $id   = $self->param('id');

    my $obj = Mojo::JSON->new->decode($self->req->body);
    my $map = $self->db->resultset('Map')->find({ guid => $id });
    return $self->render(json => {}) unless $map;
    my $map_ = $map->update($obj);
    return $self->render(json => {});
}

sub peers {
    my $self = shift;
    my $user = $self->current_user;
    my $id   = $self->param('id');

    my $obj = Mojo::JSON->new->decode($self->req->body);
    my $map = $self->db->resultset('Map')->find({ guid => $id });
    my @graders = map {
        {
            guid => $_->guid,
            map_id => $map->id,
            analysis => $_->analysis,
            graded => $_->graded,
            score => $_->score,
            filename => $_->name,
        }
    } $map->critiques;
    @graders = grep { $_->{graded} } @graders;
    my $student = $map->student;
    my @peers = map {
        {
            guid => $_->guid,
            grader_id => $_->grader_id,
            analysis => $_->analysis,
            graded => $_->graded,
            score => $_->score,
        }
    } $self->db->resultset('Critique')->search({
        grader_id => $student->id,
    })->all;

    $self->render(json => {
        peers => \@peers,
        graders => \@graders,
    });

}

sub submit{
    my $self = shift;
    my $id   = $self->param('id');
    my $map = $self->db->resultset('Map')->find({ guid => $id });
    return $self->render(json => {}) unless $map;

    my $fu = $self->req->upload('file');
    my $fn = $fu->filename;
    my ($first,$ext) = split /\./, $fn;
    my $n = $self->mkId;
    $self->app->log->debug($ext);
    my $file = $fu->move_to("public/uploads/$n.$ext");

    $map->update({
        name => "$n.$ext",
        submitted => 1,
    });

    $self->render(json => {url => "uploads/$n.$ext"});
}

1;
