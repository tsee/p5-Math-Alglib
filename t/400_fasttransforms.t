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

SCOPE: {
  note("convr1d");
  my $x = Math::Alglib::FastTransforms::convr1d(
    [1..1000],
    [reverse 1..1000],
  );

  ok(ref($x) eq 'ARRAY');
  ok(scalar(@$x));
  ok($x->[0] < $x->[scalar(@$x)/2]);
  ok((abs($x->[0] - $x->[$#$x]) / 1000 < 2));
}


TODO: {
  local $TODO = "Functions requiring test coverage";
  fail($_) for qw(
    fftc1dinv
    fftr1d
    fftr1dinv
    convc1d
    convc1dinv
    convc1dcircular
    convc1dcircularinc
    convr1dinv
    convr1dcircular
    convr1dcircularinc
    corrc1d
    corrc1dinv
    corrc1dcircular
    corrc1dcircularinv
    corrr1d
    corrr1dinv
    corrr1dcircular
    corrr1dcircularinv
    fhtr1d
    fhtr1dinv
  );
}
done_testing();
