use utf8;
package Schema::Result::Class;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Result::Class

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

=head1 TABLE: C<classes>

=cut

__PACKAGE__->table("classes");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 title

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 semester

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 archived

  data_type: 'tinyint'
  is_nullable: 1

=head2 teacher_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "title",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "semester",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "archived",
  { data_type => "tinyint", is_nullable => 1 },
  "teacher_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 assignments

Type: has_many

Related object: L<Schema::Result::Assignment>

=cut

__PACKAGE__->has_many(
  "assignments",
  "Schema::Result::Assignment",
  { "foreign.class_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 student_classes

Type: has_many

Related object: L<Schema::Result::StudentClass>

=cut

__PACKAGE__->has_many(
  "student_classes",
  "Schema::Result::StudentClass",
  { "foreign.class_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 teacher

Type: belongs_to

Related object: L<Schema::Result::Teacher>

=cut

__PACKAGE__->belongs_to(
  "teacher",
  "Schema::Result::Teacher",
  { id => "teacher_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 students

Type: many_to_many

Composing rels: L</student_classes> -> student

=cut

__PACKAGE__->many_to_many("students", "student_classes", "student");


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-07-16 15:21:25
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:76rXxdQCq4D2/YhmHhThLA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
