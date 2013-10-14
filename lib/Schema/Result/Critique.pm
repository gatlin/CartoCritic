use utf8;
package Schema::Result::Critique;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Result::Critique

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

=head1 TABLE: C<critiques>

=cut

__PACKAGE__->table("critiques");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 map_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 grader_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 analysis

  data_type: 'longtext'
  is_nullable: 1

=head2 created

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 guid

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 graded

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=head2 score

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "map_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "grader_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "analysis",
  { data_type => "longtext", is_nullable => 1 },
  "created",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "guid",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "graded",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
  "score",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 grader

Type: belongs_to

Related object: L<Schema::Result::Student>

=cut

__PACKAGE__->belongs_to(
  "grader",
  "Schema::Result::Student",
  { id => "grader_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 map

Type: belongs_to

Related object: L<Schema::Result::Map>

=cut

__PACKAGE__->belongs_to(
  "map",
  "Schema::Result::Map",
  { id => "map_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-10-14 17:57:44
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:kr9O6DT5f30DyS2Mh1PQbw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
