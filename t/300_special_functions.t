use strict;
use warnings;

use Test::More;
use Math::Alglib;
use lib 't/lib';
use Math::Alglib::Test;

pass();

TODO: {
  local $TODO = "Functions requiring test coverage";
  fail($_) for qw(
    gammafunction
    errorfunction
    errorfunctionc
    normaldistribution
    inverf
    invnormaldistribution
    incompletegamma
    incompletegammac
    invincompletegammac
    airy
    besselj0
    besselj1
    besseljn
    bessely0
    bessely1
    besselyn
    besseli0
    besseli1
    besselk0
    besselk1
    besselkn
    beta
    incompletebeta
    invincompletebeta
    binomialdistribution
    binomialcdistribution
    invbinomialdistribution
    chebyshevcalculate
    chebyshevsum
    chebyshevcoefficients
    fromchebyshev
    chisquaredistribution
    chisquarecdistribution
    invchisquaredistribution
    dawsonintegral
    ellipticintegralk
    ellipticintegralkhighprecision
    incompleteellipticintegralk
    ellipticintegrale
    incompleteellipticintegrale
    exponentialintegralei
    exponentialintegralen
    fdistribution
    fcdistribution
    invfdistribution
    fresnelintegral
    hermitecalculate
    hermitesum
    hermitecoefficients
    jacobianellipticfunctions
    laguerrecalculate
    laguerresum
    laguerrecoefficients
    legendrecalculate
    legendresum
    legendrecoefficients
    poissondistribution
    poissoncdistribution
    invpoissondistribution
    psi
    studenttdistribution
    invstudenttdistribution
    sinecosineintegrals
    hyperbolicsinecosineintegrals
  );
}

done_testing();
