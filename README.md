CartoCritic
===

A tool for cartography classrooms. (c) 2013 Gatlin Johnson

**THIS IS NOWHERE NEAR COMPLETE DON'T EVEN BOTHER RUNNING IT**
0. LICENSE
---

CartoCritic is licensed under the [WTFPL][wtfpl]. The author reserves the right
to change this at any point in the future without warning.

1. Introduction
---

CartoCritic is a tool for annotating and critiquing maps **anonymously** and
**randomly** in a cartography classroom. That's it.

2. Setup
---

The project is divided into server and client portions.

### Server

#### Dependencies

Make sure you have a recent version of Perl (5.16 or 5.18 would be splendid).
You will need the following non-core modules installed:

    Mojolicious
    Mojolicious::Plugin::Authentication
    Mojolicious::Plugin::Config
    Data::UUID
    Data::UUID::Concise
    Crypt::Eksblowfish::Bcrypt
    DBI
    DBIx::Class
    DBD::mysql
    Term::ReadPassword
    DateTime

And possibly others. Additionally, you'll want to run `schema.sql` with MySQL
to set up the database.

#### Configuration

`cp carto.conf.sample carto.conf` and edit it with your favorite text editor.

#### Running

To run the development server:

    morbo script/cartocritic

To run the pre-forking, high performance production server:

    hypnotoad script/cartocritic

To stop hypnotoad:

    hypnotoad -s script/cartocritic

See the documentation for [hypnotoad][hypnotoad] and [morbo][morbo] for more
information on those servers.

For a multitude of other ways to deploy CartoCritic - including with Apache -
please see [Mojolicious' deployment documentation][deployment].

### Client

The client is built with [AngularJS][ng] and [Twitter Bootstrap][bootstrap].
However, the client code is managed with [Yeoman][yeoman]. You don't need to
deal with any of this to run CartoCritic. Just ensure that the `public`
directory is a symlink to `ui/app/`, eg

    ln -s public ui/app/

Help
---

Feel free to contact me at <rokenrol@gmail.com>, to file an Issue in the issue
tracker, or fork this repository and make pull requests!

[wtfpl]: http://www.wtfpl.net/
[hypnotoad]: https://metacpan.org/module/Mojo::Server::Hypnotoad
[morbo]: https://metacpan.org/module/Mojo::Server::Morbo
[deployment]: https://metacpan.org/module/Mojolicious::Guides::Cookbook#DEPLOYMENT
[ng]: http://angularjs.org
[bootstrap]: http://twitter.github.io/bootstrap
[yeoman]: http://yeoman.io
