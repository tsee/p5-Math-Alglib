use strict;
use warnings;

use Test::More;
use Math::Alglib;

SCOPE: {
  my @ret;
  @ret = Math::Alglib::Statistics::samplemoments([]);
  is(scalar(@ret), 4);
  is($_, 0) for @ret;

  @ret = Math::Alglib::Statistics::samplemoments([1,1,1,1]);
  is(scalar(@ret), 4);
  is($ret[0], 1);
  is($_, 0) for @ret[1..3];
}

SCOPE: {
  note("mannwhitneyutest");
  my @ret;
  @ret = Math::Alglib::Statistics::mannwhitneyutest([],  []);
  is(scalar(@ret), 3);
  is($_, 1) for @ret[0..2];

  @ret = Math::Alglib::Statistics::mannwhitneyutest([1..100],  [100..200]);
  is(scalar(@ret), 3);
  ok($_ >= 0) for @ret[0..2];
  ok($_ <= 1) for @ret[0..2];
}

done_testing();
