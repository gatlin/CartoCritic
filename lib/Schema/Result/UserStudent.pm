use utf8;
package Schema::Result::UserStudent;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Result::UserStudent

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

=head1 TABLE: C<user_student>

=cut

__PACKAGE__->table("user_student");

=head1 ACCESSORS

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 student_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "student_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</user_id>

=item * L</student_id>

=back

=cut

__PACKAGE__->set_primary_key("user_id", "student_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<student_id>

=over 4

=item * L</student_id>

=back

=cut

__PACKAGE__->add_unique_constraint("student_id", ["student_id"]);

=head2 C<user_id>

=over 4

=item * L</user_id>

=back

=cut

__PACKAGE__->add_unique_constraint("user_id", ["user_id"]);

=head1 RELATIONS

=head2 student

Type: belongs_to

Related object: L<Schema::Result::Student>

=cut

__PACKAGE__->belongs_to(
  "student",
  "Schema::Result::Student",
  { id => "student_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 user

Type: belongs_to

Related object: L<Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "Schema::Result::User",
  { id => "user_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-07-16 15:27:19
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:fJsT2vvJiW20v7bsTvQDZw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
