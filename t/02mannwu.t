use strict;
use warnings;

use Test::More tests => 4;
use Math::Alglib;

my @ret = Math::Alglib::Statistics::mannwhitneyutest([],  []);
ok(@ret==3);
is($_, 1) for @ret[0..2];


#my @ret = Math::Alglib::Statistics::mannwhitneyutest([1,2,3,4,1,1,1,1,1,1],  [5,6,1,2,3,1,12,3,]);
#use Data::Dumper;warn Dumper \@ret;

# TODO proper tests
