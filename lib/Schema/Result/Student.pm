use utf8;
package Schema::Result::Student;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Result::Student

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

=head1 TABLE: C<students>

=cut

__PACKAGE__->table("students");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<user_id>

=over 4

=item * L</user_id>

=back

=cut

__PACKAGE__->add_unique_constraint("user_id", ["user_id"]);

=head1 RELATIONS

=head2 critiques

Type: has_many

Related object: L<Schema::Result::Critique>

=cut

__PACKAGE__->has_many(
  "critiques",
  "Schema::Result::Critique",
  { "foreign.student_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 maps

Type: has_many

Related object: L<Schema::Result::Map>

=cut

__PACKAGE__->has_many(
  "maps",
  "Schema::Result::Map",
  { "foreign.student_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 student_classes

Type: has_many

Related object: L<Schema::Result::StudentClass>

=cut

__PACKAGE__->has_many(
  "student_classes",
  "Schema::Result::StudentClass",
  { "foreign.student_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
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

=head2 classes

Type: many_to_many

Composing rels: L</student_classes> -> class

=cut

__PACKAGE__->many_to_many("classes", "student_classes", "class");


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-07-16 17:07:48
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:VIx0db6NIrLK8KYDnDlK2g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
