package Math::Alglib::Test;
use strict;
use warnings;
use Test::More ();
use Data::Dumper;

use Exporter 'import';
our @EXPORT = qw(is_aryref is_approx);

sub is_aryref {
  my $ref = shift;
  my $n = shift;
  my $desc = shift;

  my $ok = Test::More::ok(ref($ref) eq 'ARRAY' && (defined($n) ? (scalar(@$ref) == $n) : 1), (defined $desc ? $desc : ()));
  $ok or Test::More::diag("Not an array ref or incorrect number of elements: " . Dumper($ref));
  return $ok;
}

sub is_approx {
  my ($x, $ref, $eps, $desc) = @_;
  my $ok = Test::More::ok($x+$eps > $ref && $x-$eps < $ref, $desc);
  $ok or Test::More::diag("'$x' is not approximately (eps=$eps) equal to '$ref'");
  return $ok;
}

1;
