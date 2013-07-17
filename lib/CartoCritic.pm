package CartoCritic;
use Mojo::Base 'Mojolicious';
use Schema;

use Mojolicious::Plugin::Config;
use Mojolicious::Plugin::Authentication;

use Crypt::Eksblowfish::Bcrypt qw(bcrypt_hash);
use Data::UUID;
use Data::UUID::Concise;
use Data::Dump qw(pp);

# This method will run once at server start
sub startup {
    my $self = shift;

    # Documentation browser under "/perldoc"
    $self->plugin('PODRenderer');

    # Config
    my $config = $self->plugin(config => {
          file => 'carto.conf'
    });

    # database
    $self->helper(db => sub {
        my $dbh = $config->{db_host};
        my $dbp = $config->{db_port};
        my $dbn = $config->{db_name};
        my $dbu = $config->{db_user};
        my $dbq = $config->{db_pass};

        Schema->connect("DBI:mysql:$dbn:$dbh:$dbp",
            $dbu,$dbq, { AutoCommit => 1 }
        );
    });

    # helper routines
    $self->helper(mkId => sub {
        Data::UUID::Concise->new->encode((Data::UUID->new)->create_str);
    });

    $self->helper(encrypt => sub {
        my ($self, $password) = @_;
        my $crypt_settings = {
            key_nul => 1,
            cost => 8,
            salt => $config->{salt},
        };
        my $encrypted = bcrypt_hash($crypt_settings, $password);
        return $encrypted;
    });

    $self->plugin(authentication => {
        autoload_user => 1,
        session_key => $config->{session_key},
        load_user => sub {
            my ($self, $uid) = @_;
            my $user = undef;
            if (defined $uid) {
                $user = $self->db->resultset('User')->find(
                    { username => $uid },
                );
            }
            return $user;
        },
        validate_user => sub {
            my ($self, $username, $password, $extradata) = @_;
            my $uid = undef;
            my $obj = $self->db->resultset('User')->find(
                { username => $username }
            ) // undef;
            if (not defined $obj) {
                return undef;
            }
            $uid = $username if $self->encrypt($password) eq $obj->password;
            return $uid;
        },
    });

    # Router
    my $r = $self->routes;

    # Normal route to controller
    #    $r->get('/')->to('example#welcome');
    $r->get('/')->to('page#index');
    $r->get('/login')->to(cb => sub {
         my $self = shift;
         $self->render_static('login.html');
    });
    $r->get('/register')->to(cb => sub {
        my $self = shift;
        $self->render_static('register.html');
    });
    $r->post('/login')->to('user#login');
    $r->post('/register')->to('user#register');

    my $auth = $r->bridge('/app')->to('user#check');
    $auth->get('/')->to('page#main');
    $auth->get('/logout')->to('user#logout_user');

=cut
    my $api  = $r->bridge('/api/v1')->to('user#check');
    ###
    # Class
    $api->get('/classes')->to('class#list');
    $api->get('/classes/:id')->to('class#retrieve');
    $api->post('/classes')->to('class#create');
    $api->put('/classes/:id')->to('class#update');
    $api->delete('/classes/:id')->to('class#remove');

    $api->get('/classes/:id/assignments')->to('assignments#for_class');

    ###
    # Students
    $api->get('/students')->to('student#list');
    $api->get('/students/:id')->to('student#retrieve');
    $api->post('/students')->to('student#create');
    $api->put('/students/:id')->to('student#update');
    $api->delete('/students/:id')->to('student#remove');

    $api->get('/students/:id/critiques')->to('student#critiques');

    ###
    # Maps
    $api->get('/maps')->to('map#list');
    $api->get('/maps/:id')->to('map#retrieve');
    $api->post('/maps')->to('map#create');
    $api->put('/maps/:id')->to('map#update');
    $api->delete('/maps/:id')->to('map#remove');

    $api->post('/maps/:id/grade')->to('map#grade');

    ###
    # Assignments
    $api->get('/assignments')->to('assignment#list');
    $api->get('/assignments/:id')->to('assignment#retrieve');
    $api->post('/assignments')->to('assignment#create');
    $api->put('/assignments/:id')->to('assignment#update');
    $api->delete('/assignments/:id')->to('assignment#remove');
=cut
}

1;
