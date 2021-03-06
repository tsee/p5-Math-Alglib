use strict;
use warnings;

use Test::More;
use Math::Alglib;
use lib 't/lib';
use Math::Alglib::Test;
#use Math::Alglib::Interpolation;

pass();

SCOPE: {
  note("idwbuildmodifiedshepard");
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

SCOPE: {
  note("spline3dbuildtrilinearv");
  my $spl = Math::Alglib::Interpolation::spline3dbuildtrilinearv(
    [0..9], 10, [0..9], 10, [0..9], 10,
    [0..999],
    1
  );
  isa_ok($spl, 'Math::Alglib::Interpolation::Spline3dInterpolant');
  my $x = $spl->spline3dcalc(1, 1, 1);
  ok(($x > 111 - 1e-9 and $x < 111 + 1e-9), "spline3dcalc");
  my $r = $spl->spline3dunpackv();
  is(ref($r), 'ARRAY', "spline3dunpackv ret type");
  is(scalar(@$r), 6, "spline3dunpackv ret len");
  is(ref($r->[5]), 'ARRAY', "spline3dunpackv ret array");
}

SCOPE: {
  note("lsfit");
  my $lsf = Math::Alglib::Interpolation::lsfitcreatef(
    [
      [0, 0],
      [0, 1],
      [1, 0],
      [1, 1],
    ],
    [0, 1, 1, 2],
    [1],
    0.05
  );
  isa_ok($lsf, "Math::Alglib::Interpolation::LsFitState");

  $lsf->lsfitfit_func(sub {
    is(scalar(@_), 3);
    my ($obj, $c, $x) = @_;
    isa_ok($obj, "Math::Alglib::Interpolation::LsFitState");
    is(ref($c), 'ARRAY') or die;
    is(ref($x), 'ARRAY') or die;
    is(scalar(@$c), 1);
    is(scalar(@$x), 2);
    return 0.;
  });

  my $res = $lsf->lsfitresults;
  is(ref($res), "ARRAY");
  is(scalar(@$res), 3);
  is(int($res->[0]), $res->[0]);
  is(ref($res->[1]), 'ARRAY');
  is(ref($res->[2]), 'HASH');
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
    lsfitlinearc
    ~pspline3interpolator
    ~pspline2interpolator
    pspline3buildperiodic
    pspline3build
    pspline2buildperiodic
    pspline2build
    pspline3parametervalues
    pspline2parametervalues
    pspline3calc
    pspline2calc
    pspline3tangent
    pspline2tangent
    pspline3diff
    pspline2diff
    pspline3diff2
    pspline2diff2
    pspline3arclength
    pspline2arclength
    ~rbfmodel
    rbfcreate
    rbfserialize
    rbfunserialize
    rbfsetalgoqnn
    rbfsetalgomultilayer
    rbfsetlinterm
    rbfsetconstterm
    rbfsetzeroterm
    rbfbuildmodel
    rbfcalc
    rbfcalc2
    rbfcalc3
    rbfgridcalc2
    rbfunpack
    spline2dinterpolant
    ~spline2dinterpolant
    spline2dcalc
    spline2ddiff
    spline2dlintransxy
    spline2dlintransf
    spline2dresamplebicubic
    spline2dresamplebilinear
    spline2dbuildbilinearv
    spline2dbuildbicubicv
    spline2dcalcv
    spline2dcalcvbuf
    spline2dunpackv
    spline2dbuildbilinear
    spline2dbuildbicubic
    spline2dunpack
    spline3dlintransxyz
    spline3dlintransf
    spline3dcalcvbuf
    spline3dcalcv
    lsfitsetscale
    lsfitsetxrep
    lsfitsetstpmax
    lsfitsetcond
    lsfitcreatewf
    lsfitcreatewfg
    lsfitcreatefg
    lsfitcreatewfgh
    lsfitcreatefgh
    lsfitresults
    lsfitsetgradientcheck
    lstfitpiecewiselinearrdpfixed
    lstfitpiecewiselinearrdp
    logisticcalc4
    logisticcalc5
    logisticfit4
    logisticfit4ec
    logisticfit5
    logisticfit5ec
    logisticfit45x
    parametricrdpfixed
  );
}

done_testing();
