package Math::Alglib::Test;
use strict;
use warnings;
use Test::More ();
use Data::Dumper;

use Exporter 'import';
our @EXPORT = qw(is_aryref);

sub is_aryref {
  my $ref = shift;
  my $n = shift;
  my $desc = shift;

  my $ok = Test::More::ok(ref($ref) eq 'ARRAY' && (defined($n) ? (scalar(@$ref) == $n) : 1), (defined $desc ? $desc : ()));
  $ok or Test::More::diag("Not an array ref or incorrect number of elements: " . Dumper($ref));
  return $ok;
}

1;
