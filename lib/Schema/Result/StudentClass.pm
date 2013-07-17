use utf8;
package Schema::Result::StudentClass;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Result::StudentClass

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

=head1 TABLE: C<student_class>

=cut

__PACKAGE__->table("student_class");

=head1 ACCESSORS

=head2 student_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 class_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "student_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "class_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</student_id>

=item * L</class_id>

=back

=cut

__PACKAGE__->set_primary_key("student_id", "class_id");

=head1 RELATIONS

=head2 class

Type: belongs_to

Related object: L<Schema::Result::Class>

=cut

__PACKAGE__->belongs_to(
  "class",
  "Schema::Result::Class",
  { id => "class_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

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


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-07-16 11:55:44
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:NGJgtzPJOFH+11n9FbDW9A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
