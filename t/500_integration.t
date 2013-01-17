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
    gqgeneraterec
    gqgenerategausslobattorec
    gqgenerategaussradaurec
    gqgenerategausslegendre
    gqgenerategaussjacobi
    gqgenerategausslaguerre
    gqgenerategausshermite

    gkqgeneraterec
    gkqgenerategausslegendre
  );
}

done_testing();
