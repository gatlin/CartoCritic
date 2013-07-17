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

=head2 student_id

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

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "map_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "student_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "analysis",
  { data_type => "longtext", is_nullable => 1 },
  "created",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

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
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:CI98Pq+954pT8fCxAagGbA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
