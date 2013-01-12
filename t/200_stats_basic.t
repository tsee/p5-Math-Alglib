use strict;
use warnings;

use Test::More;
use Math::Alglib;
use lib 't/lib';
use Math::Alglib::Test;

SCOPE: {
  note('samplemoments');
  my @ret;
  @ret = Math::Alglib::Statistics::samplemoments([]);
  is_deeply(\@ret, [[0, 0, 0, 0]]);

  @ret = Math::Alglib::Statistics::samplemoments([1,1,1,1]);
  is_deeply(\@ret, [[1, 0, 0 ,0]]);

  note('samplemedian');
  my $median = Math::Alglib::Statistics::samplemedian([]);
  is($median, 0);
  $median = Math::Alglib::Statistics::samplemedian([1,2,3]);
  is($median, 2);
}

SCOPE: {
  note("mannwhitneyutest");
  my @ret;
  @ret = Math::Alglib::Statistics::mannwhitneyutest([],  []);
  is_deeply(\@ret, [[1, 1, 1]]);

  @ret = Math::Alglib::Statistics::mannwhitneyutest([1..100],  [100..200]);
  is(scalar(@ret), 1);
  is_aryref($ret[0], 3, "mannwhitneyutest returns array ref with 3 elemes");
  my $r = $ret[0];
  ok($_ >= 0) for @$r[0..2];
  ok($_ <= 1) for @$r[0..2];
}

done_testing();
