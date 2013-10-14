use utf8;
package Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Result::User

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<users>

=cut

__PACKAGE__->table("users");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 username

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 password

  data_type: 'varbinary'
  is_nullable: 1
  size: 100

=head2 email

  data_type: 'varchar'
  is_nullable: 1
  size: 256

=head2 role

  data_type: 'varchar'
  default_value: 'student'
  is_nullable: 0
  size: 50

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "username",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "password",
  { data_type => "varbinary", is_nullable => 1, size => 100 },
  "email",
  { data_type => "varchar", is_nullable => 1, size => 256 },
  "role",
  {
    data_type => "varchar",
    default_value => "student",
    is_nullable => 0,
    size => 50,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<username>

=over 4

=item * L</username>

=back

=cut

__PACKAGE__->add_unique_constraint("username", ["username"]);

=head1 RELATIONS

=head2 roles

Type: has_many

Related object: L<Schema::Result::Role>

=cut

__PACKAGE__->has_many(
  "roles",
  "Schema::Result::Role",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 teacher

Type: might_have

Related object: L<Schema::Result::Teacher>

=cut

__PACKAGE__->might_have(
  "teacher",
  "Schema::Result::Teacher",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-10-13 20:00:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:2ZLtIr8+uDUeS9F7BUI8Mw
# These lines were loaded from './Schema/Result/User.pm' found in @INC.
# They are now part of the custom portion of this file
# for you to hand-edit.  If you do not either delete
# this section or remove that file from @INC, this section
# will be repeated redundantly when you re-create this
# file again via Loader!  See skip_load_external to disable
# this feature.

use utf8;
package Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Result::User

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<users>

=cut

__PACKAGE__->table("users");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 username

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 password

  data_type: 'varbinary'
  is_nullable: 1
  size: 100

=head2 email

  data_type: 'varchar'
  is_nullable: 1
  size: 256

=head2 role

  data_type: 'varchar'
  default_value: 'student'
  is_nullable: 0
  size: 50

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "username",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "password",
  { data_type => "varbinary", is_nullable => 1, size => 100 },
  "email",
  { data_type => "varchar", is_nullable => 1, size => 256 },
  "role",
  {
    data_type => "varchar",
    default_value => "student",
    is_nullable => 0,
    size => 50,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 student

Type: might_have

Related object: L<Schema::Result::Student>

=cut

__PACKAGE__->might_have(
  "student",
  "Schema::Result::Student",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 teacher

Type: might_have

Related object: L<Schema::Result::Teacher>

=cut

__PACKAGE__->might_have(
  "teacher",
  "Schema::Result::Teacher",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-07-17 15:35:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:oN+dMmT0HdYuPHWXvbvM7g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
# End of lines loaded from './Schema/Result/User.pm' 
# These lines were loaded from './Schema/Result/User.pm' found in @INC.
# They are now part of the custom portion of this file
# for you to hand-edit.  If you do not either delete
# this section or remove that file from @INC, this section
# will be repeated redundantly when you re-create this
# file again via Loader!  See skip_load_external to disable
# this feature.

use utf8;
package Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Result::User

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<users>

=cut

__PACKAGE__->table("users");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 username

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 password

  data_type: 'varbinary'
  is_nullable: 1
  size: 100

=head2 email

  data_type: 'varchar'
  is_nullable: 1
  size: 256

=head2 role

  data_type: 'varchar'
  default_value: 'student'
  is_nullable: 0
  size: 50

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "username",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "password",
  { data_type => "varbinary", is_nullable => 1, size => 100 },
  "email",
  { data_type => "varchar", is_nullable => 1, size => 256 },
  "role",
  {
    data_type => "varchar",
    default_value => "student",
    is_nullable => 0,
    size => 50,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 student

Type: might_have

Related object: L<Schema::Result::Student>

=cut

__PACKAGE__->might_have(
  "student",
  "Schema::Result::Student",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 teacher

Type: might_have

Related object: L<Schema::Result::Teacher>

=cut

__PACKAGE__->might_have(
  "teacher",
  "Schema::Result::Teacher",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-07-17 15:35:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:oN+dMmT0HdYuPHWXvbvM7g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
# End of lines loaded from './Schema/Result/User.pm' 


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
