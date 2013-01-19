use strict;
use warnings;

use Test::More;
use Math::Alglib;
use lib 't/lib';
use Math::Alglib::Test;
#use Math::Alglib::Interpolation;

pass();

my $int = Math::Alglib::Interpolation::idwbuildmodifiedshepard(
  [
    [0, 0],
    [1, 0.5],
    [2, 1],
    [3, 1.5],
  ],
  4, 1, 1, 20, 40
);

isa_ok($int, 'Math::Alglib::Interpolation::Idwinterpolant');

is_approx($int->idwcalc([0]), 0, 1e-9);
is_approx($int->idwcalc([1]), 0.5, 1e-9);
is_approx($int->idwcalc([2]), 1., 1e-9);
is_approx($int->idwcalc([2.5]), 1.25, 1e-9);

TODO: {
  local $TODO = "Functions requiring test coverage";
  fail($_) for qw(
    idwbuildmodifiedshepardr
  );
}

done_testing();
