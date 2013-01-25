use strict;
use warnings;

use Test::More;
use Math::Alglib;
use lib 't/lib';
use Math::Alglib::Test;
#use Math::Alglib::Interpolation;

pass();

SCOPE: {
  my $p = [
    [0, 0],
    [1, 0.5],
    [2, 1],
    [3, 1.5],
  ];
  my $int = Math::Alglib::Interpolation::idwbuildmodifiedshepard(
    $p, 4, 1, 1, 20, 40
  );
  isa_ok($int, 'Math::Alglib::Interpolation::IdwInterpolant');

  is_approx($int->idwcalc([0]), 0, 1e-9);
  is_approx($int->idwcalc([1]), 0.5, 1e-9);
  is_approx($int->idwcalc([2]), 1., 1e-9);
  is_approx($int->idwcalc([2.5]), 1.25, 1e-9);

  $int = Math::Alglib::Interpolation::idwbuildmodifiedshepardr(
    $p, 4, 1, 12.
  );
  isa_ok($int, 'Math::Alglib::Interpolation::IdwInterpolant');

  $int = Math::Alglib::Interpolation::idwbuildnoisy(
    $p,
    4, 1, 2, 20, 40
  );
  isa_ok($int, 'Math::Alglib::Interpolation::IdwInterpolant');
}

TODO: {
  local $TODO = "Functions requiring test coverage";
  fail($_) for qw(
    barycentricbuildxyw
    barycentricbuildfloaterhormann
    ~barycentricinterpolant
    barycentriccalc
    barycentricdiff1
    barycentricdiff2
    barycentriclintransx
    barycentriclintransy
    barycentricunpack
    polynomialbar2cheb
    polynomialcheb2bar
    polynomialbar2pow
    polynomialpow2bar
    polynomialbuild
    polynomialbuildeqdist
    polynomialbuildcheb1
    polynomialbuildcheb2
    polynomialcalceqdist
    polynomialcalccheb1
    polynomialcalccheb2
    ~spline1dinterpolant
    spline1dcalc
    spline1ddiff
    spline1dunpack
    spline1dlintransx
    spline1dlintransy
    spline1dintegrate
    spline1dbuildlinear
    spline1dbuildcubic
    spline1dgriddiffcubic
    spline1dconvcubic
    spline1dconvdiffcubic
    spline1dconvdiff2cubic
    spline1dbuildcatmullrom
    spline1dbuildhermite
    spline1dbuildakima
    spline1dbuildmonotone
    polynomialfit
    polynomialfitwc
    barycentricfitfloaterhormannwc
    barycentricfitfloaterhormann
    spline1dfitpenalized
    spline1dfitpenalizedw
    spline1dfitcubicwc
    spline1dfithermitewc
    spline1dfitcubic
    spline1dfithermite
    lsfitlinearw
    lsfitlinearwc
    lsfitlinear
  );
}

done_testing();
