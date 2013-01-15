use strict;
use warnings;

use Test::More;
use Math::Alglib;
use Math::Alglib::FastTransforms;
pass();

SCOPE: {
  note("fftc1d");
  my $in = 
    [
      [1, 2],
      [2, 1],
      [3, 4]
    ];
  my $x = Math::Alglib::FastTransforms::fftc1d($in);

  ok(ref($x) eq 'ARRAY');
  is(scalar(@$x), 3);
  ok(ref($x->[$_]) eq 'ARRAY', "elem is array ($_)") for 0..$#$x;
  is(scalar(@{$x->[$_]}), 2, "elem is array w/ two elems($_)") for 0..$#$x;
}


TODO: {
  local $TODO = "Functions requiring test coverage";
  fail($_) for qw(
    fftc1dinv
    fftr1d
    fftr1dinv
  );
}
done_testing();
