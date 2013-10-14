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

=head2 fname

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 lname

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 email

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "fname",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "lname",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "email",
  { data_type => "varchar", is_nullable => 1, size => 100 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 critiques

Type: has_many

Related object: L<Schema::Result::Critique>

=cut

__PACKAGE__->has_many(
  "critiques",
  "Schema::Result::Critique",
  { "foreign.grader_id" => "self.id" },
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

=head2 classes

Type: many_to_many

Composing rels: L</student_classes> -> class

=cut

__PACKAGE__->many_to_many("classes", "student_classes", "class");


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-10-13 20:00:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:vhiFMBJnVvCSh3WHwofpdg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
