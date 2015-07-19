package Math::Alglib::Statistics;
use strict;
use warnings;

use Math::Alglib;

1;
__END__

=head1 NAME

Math::Alglib::SpecialFunctions - Alglib special functions wrapper

=head1 DESCRIPTION

This module is a wrapper for the special functions found in Alglib.
This documentation is auto-generated from the F<specialfunctions.h>
header file of the library. If in doubt about the completeness of
this documentation, please file a bug and refer to the header file.

=head1 VERSION

This module wraps Alglib version 3.9.0.

=head1 FUNCTIONS

For each function, the C++ signature is included in the documentation
below. The Perl interface may have slightly different semantics.
Generally speaking:

=over 2

=item *

Any mention of C<ae_int_t> or  C<ptrdiff_t> is to be consider a
(technically signed) integer.

=item *

Functions of the form C<void foo(double bar, double &baz)> are
using the C++-style of passing output parameters into the function
via references. That is equivalent to modifying C<@_> in Perl.
The Perl calling convention for these functions becomes:

  double foo(double bar)

where the return value is C<baz> in the C++ signature above.
If there are multiple such output parameters, the return
value will be a reference to an array containing the values
instead of returning a list of values.

If unsure about what's an input and what's an output parameter,
check the (textual, non-code) documentation that was extracted
from the headers.

=item *

One exception to the pass-in style of output parameters is when
a (typically composite type) parameter is a C++ const reference
such as the C<const real_1d_array &x> in:

  void samplemoments(const real_1d_array &x, double &mean,
                     double &variance, double &skewness,
                     double &kurtosis);

The parameter C<x> is the only I<input> parameter here.
See below about what the type means.

=item *

The types C<real_1d_array> and C<real_2d_array> are converted to/from
Perl array references and nested Perl array references respectively.

A C<real_1d_array> is:

  [1.1, 2.2, 3.3, 4.4]

A C<real_2d_array> would be:

  [ [1.1, 2.1, 3.1],
    [5.2, 6.2, 7.2],
    [4.0, 3.0, 2.0],
    [7.3, 8.3, 9.3]
  ]

where the matrix does not necessarily have to contain the same number
of rows and columns, but the number of columns in each row must be
the same.

=back

=head2 Calculation of the distribution moments: mean, variance, skewness, kurtosis.

  void samplemoments(const real_1d_array &x, double &mean, double &variance, double &skewness, double &kurtosis);

  INPUT PARAMETERS:
      X       -   sample
      N       -   N>=0, sample size:
                  * if given, only leading N elements of X are processed
                  * if not given, automatically determined from size of X
  
  OUTPUT PARAMETERS
      Mean    -   mean.
      Variance-   variance.
      Skewness-   skewness (if variance<>0; zero otherwise).
      Kurtosis-   kurtosis (if variance<>0; zero otherwise).
  
  
    -- ALGLIB --
       Copyright 06.09.2006 by Bochkanov Sergey

=head2 Calculation of the mean.

  double samplemean(const real_1d_array &x);

  INPUT PARAMETERS:
      X       -   sample
      N       -   N>=0, sample size:
                  * if given, only leading N elements of X are processed
                  * if not given, automatically determined from size of X
  
  NOTE:
  
  This function return result  which calculated by 'SampleMoments' function
  and stored at 'Mean' variable.
  
  
    -- ALGLIB --
       Copyright 06.09.2006 by Bochkanov Sergey

=head2 Calculation of the variance.

  double samplevariance(const real_1d_array &x);

  INPUT PARAMETERS:
      X       -   sample
      N       -   N>=0, sample size:
                  * if given, only leading N elements of X are processed
                  * if not given, automatically determined from size of X
  
  NOTE:
  
  This function return result  which calculated by 'SampleMoments' function
  and stored at 'Variance' variable.
  
  
    -- ALGLIB --
       Copyright 06.09.2006 by Bochkanov Sergey

=head2 Calculation of the skewness.

  double sampleskewness(const real_1d_array &x);

  INPUT PARAMETERS:
      X       -   sample
      N       -   N>=0, sample size:
                  * if given, only leading N elements of X are processed
                  * if not given, automatically determined from size of X
  
  NOTE:
  
  This function return result  which calculated by 'SampleMoments' function
  and stored at 'Skewness' variable.
  
  
    -- ALGLIB --
       Copyright 06.09.2006 by Bochkanov Sergey

=head2 Calculation of the kurtosis.

  double samplekurtosis(const real_1d_array &x);

  INPUT PARAMETERS:
      X       -   sample
      N       -   N>=0, sample size:
                  * if given, only leading N elements of X are processed
                  * if not given, automatically determined from size of X
  
  NOTE:
  
  This function return result  which calculated by 'SampleMoments' function
  and stored at 'Kurtosis' variable.
  
  
    -- ALGLIB --
       Copyright 06.09.2006 by Bochkanov Sergey

=head2 ADev

  void sampleadev(const real_1d_array &x, double &adev);

  Input parameters:
      X   -   sample
      N   -   N>=0, sample size:
              * if given, only leading N elements of X are processed
              * if not given, automatically determined from size of X
  
  Output parameters:
      ADev-   ADev
  
    -- ALGLIB --
       Copyright 06.09.2006 by Bochkanov Sergey

=head2 Median calculation.

  void samplemedian(const real_1d_array &x, double &median);

  Input parameters:
      X   -   sample (array indexes: [0..N-1])
      N   -   N>=0, sample size:
              * if given, only leading N elements of X are processed
              * if not given, automatically determined from size of X
  
  Output parameters:
      Median
  
    -- ALGLIB --
       Copyright 06.09.2006 by Bochkanov Sergey

=head2 Percentile calculation.

  void samplepercentile(const real_1d_array &x, const double p, double &v);

  Input parameters:
      X   -   sample (array indexes: [0..N-1])
      N   -   N>=0, sample size:
              * if given, only leading N elements of X are processed
              * if not given, automatically determined from size of X
      P   -   percentile (0<=P<=1)
  
  Output parameters:
      V   -   percentile
  
    -- ALGLIB --
       Copyright 01.03.2008 by Bochkanov Sergey

=head2 2-sample covariance

  double cov2(const real_1d_array &x, const real_1d_array &y);

  Input parameters:
      X       -   sample 1 (array indexes: [0..N-1])
      Y       -   sample 2 (array indexes: [0..N-1])
      N       -   N>=0, sample size:
                  * if given, only N leading elements of X/Y are processed
                  * if not given, automatically determined from input sizes
  
  Result:
      covariance (zero for N=0 or N=1)
  
    -- ALGLIB --
       Copyright 28.10.2010 by Bochkanov Sergey

=head2 Pearson product-moment correlation coefficient

  double pearsoncorr2(const real_1d_array &x, const real_1d_array &y);

  Input parameters:
      X       -   sample 1 (array indexes: [0..N-1])
      Y       -   sample 2 (array indexes: [0..N-1])
      N       -   N>=0, sample size:
                  * if given, only N leading elements of X/Y are processed
                  * if not given, automatically determined from input sizes
  
  Result:
      Pearson product-moment correlation coefficient
      (zero for N=0 or N=1)
  
    -- ALGLIB --
       Copyright 28.10.2010 by Bochkanov Sergey

=head2 Spearman's rank correlation coefficient

  double spearmancorr2(const real_1d_array &x, const real_1d_array &y);

  Input parameters:
      X       -   sample 1 (array indexes: [0..N-1])
      Y       -   sample 2 (array indexes: [0..N-1])
      N       -   N>=0, sample size:
                  * if given, only N leading elements of X/Y are processed
                  * if not given, automatically determined from input sizes
  
  Result:
      Spearman's rank correlation coefficient
      (zero for N=0 or N=1)
  
    -- ALGLIB --
       Copyright 09.04.2007 by Bochkanov Sergey

=head2 Covariance matrix

  void covm(const real_2d_array &x, real_2d_array &c);

  
  INPUT PARAMETERS:
      X   -   array[N,M], sample matrix:
              * J-th column corresponds to J-th variable
              * I-th row corresponds to I-th observation
      N   -   N>=0, number of observations:
              * if given, only leading N rows of X are used
              * if not given, automatically determined from input size
      M   -   M>0, number of variables:
              * if given, only leading M columns of X are used
              * if not given, automatically determined from input size
  
  OUTPUT PARAMETERS:
      C   -   array[M,M], covariance matrix (zero if N=0 or N=1)
  
    -- ALGLIB --
       Copyright 28.10.2010 by Bochkanov Sergey

=head2 Pearson product-moment correlation matrix

  void pearsoncorrm(const real_2d_array &x, real_2d_array &c);

  
  INPUT PARAMETERS:
      X   -   array[N,M], sample matrix:
              * J-th column corresponds to J-th variable
              * I-th row corresponds to I-th observation
      N   -   N>=0, number of observations:
              * if given, only leading N rows of X are used
              * if not given, automatically determined from input size
      M   -   M>0, number of variables:
              * if given, only leading M columns of X are used
              * if not given, automatically determined from input size
  
  OUTPUT PARAMETERS:
      C   -   array[M,M], correlation matrix (zero if N=0 or N=1)
  
    -- ALGLIB --
       Copyright 28.10.2010 by Bochkanov Sergey

=head2 Spearman's rank correlation matrix

  void spearmancorrm(const real_2d_array &x, real_2d_array &c);

  
  INPUT PARAMETERS:
      X   -   array[N,M], sample matrix:
              * J-th column corresponds to J-th variable
              * I-th row corresponds to I-th observation
      N   -   N>=0, number of observations:
              * if given, only leading N rows of X are used
              * if not given, automatically determined from input size
      M   -   M>0, number of variables:
              * if given, only leading M columns of X are used
              * if not given, automatically determined from input size
  
  OUTPUT PARAMETERS:
      C   -   array[M,M], correlation matrix (zero if N=0 or N=1)
  
    -- ALGLIB --
       Copyright 28.10.2010 by Bochkanov Sergey

=head2 Cross-covariance matrix

  void covm2(const real_2d_array &x, const real_2d_array &y, real_2d_array &c);

  
  INPUT PARAMETERS:
      X   -   array[N,M1], sample matrix:
              * J-th column corresponds to J-th variable
              * I-th row corresponds to I-th observation
      Y   -   array[N,M2], sample matrix:
              * J-th column corresponds to J-th variable
              * I-th row corresponds to I-th observation
      N   -   N>=0, number of observations:
              * if given, only leading N rows of X/Y are used
              * if not given, automatically determined from input sizes
      M1  -   M1>0, number of variables in X:
              * if given, only leading M1 columns of X are used
              * if not given, automatically determined from input size
      M2  -   M2>0, number of variables in Y:
              * if given, only leading M1 columns of X are used
              * if not given, automatically determined from input size
  
  OUTPUT PARAMETERS:
      C   -   array[M1,M2], cross-covariance matrix (zero if N=0 or N=1)
  
    -- ALGLIB --
       Copyright 28.10.2010 by Bochkanov Sergey

=head2 Pearson product-moment cross-correlation matrix

  void pearsoncorrm2(const real_2d_array &x, const real_2d_array &y, real_2d_array &c);

  
  INPUT PARAMETERS:
      X   -   array[N,M1], sample matrix:
              * J-th column corresponds to J-th variable
              * I-th row corresponds to I-th observation
      Y   -   array[N,M2], sample matrix:
              * J-th column corresponds to J-th variable
              * I-th row corresponds to I-th observation
      N   -   N>=0, number of observations:
              * if given, only leading N rows of X/Y are used
              * if not given, automatically determined from input sizes
      M1  -   M1>0, number of variables in X:
              * if given, only leading M1 columns of X are used
              * if not given, automatically determined from input size
      M2  -   M2>0, number of variables in Y:
              * if given, only leading M1 columns of X are used
              * if not given, automatically determined from input size
  
  OUTPUT PARAMETERS:
      C   -   array[M1,M2], cross-correlation matrix (zero if N=0 or N=1)
  
    -- ALGLIB --
       Copyright 28.10.2010 by Bochkanov Sergey

=head2 Spearman's rank cross-correlation matrix

  void spearmancorrm2(const real_2d_array &x, const real_2d_array &y, real_2d_array &c);

  
  INPUT PARAMETERS:
      X   -   array[N,M1], sample matrix:
              * J-th column corresponds to J-th variable
              * I-th row corresponds to I-th observation
      Y   -   array[N,M2], sample matrix:
              * J-th column corresponds to J-th variable
              * I-th row corresponds to I-th observation
      N   -   N>=0, number of observations:
              * if given, only leading N rows of X/Y are used
              * if not given, automatically determined from input sizes
      M1  -   M1>0, number of variables in X:
              * if given, only leading M1 columns of X are used
              * if not given, automatically determined from input size
      M2  -   M2>0, number of variables in Y:
              * if given, only leading M1 columns of X are used
              * if not given, automatically determined from input size
  
  OUTPUT PARAMETERS:
      C   -   array[M1,M2], cross-correlation matrix (zero if N=0 or N=1)
  
    -- ALGLIB --
       Copyright 28.10.2010 by Bochkanov Sergey

=head2 This function replaces data in XY by their ranks:

Note on the Perl wrapper:
Returns modified data structure as a copy rather than modifying in-place like in C++.

  void rankdata(real_2d_array &xy);

  * XY is processed row-by-row
  * rows are processed separately
  * tied data are correctly handled (tied ranks are calculated)
  * ranking starts from 0, ends at NFeatures-1
  * sum of within-row values is equal to (NFeatures-1)*NFeatures/2
  
  
  INPUT PARAMETERS:
      XY      -   array[NPoints,NFeatures], dataset
      NPoints -   number of points
      NFeatures-  number of features
  
  OUTPUT PARAMETERS:
      XY      -   data are replaced by their within-row ranks;
                  ranking starts from 0, ends at NFeatures-1
  
    -- ALGLIB --
       Copyright 18.04.2013 by Bochkanov Sergey

=head2 This function replaces data in XY by their CENTERED ranks:

Note on the Perl wrapper:
Returns modified data structure as a copy rather than modifying in-place like in C++.

  void rankdatacentered(real_2d_array &xy);

  * XY is processed row-by-row
  * rows are processed separately
  * tied data are correctly handled (tied ranks are calculated)
  * centered ranks are just usual ranks, but centered in such way  that  sum
    of within-row values is equal to 0.0.
  * centering is performed by subtracting mean from each row, i.e it changes
    mean value, but does NOT change higher moments
  
  
  INPUT PARAMETERS:
      XY      -   array[NPoints,NFeatures], dataset
      NPoints -   number of points
      NFeatures-  number of features
  
  OUTPUT PARAMETERS:
      XY      -   data are replaced by their within-row ranks;
                  ranking starts from 0, ends at NFeatures-1
  
    -- ALGLIB --
       Copyright 18.04.2013 by Bochkanov Sergey

=head2 Obsolete function, we recommend to use PearsonCorr2().

  double pearsoncorrelation(const real_1d_array &x, const real_1d_array &y, const ae_int_t n);

    -- ALGLIB --
       Copyright 09.04.2007 by Bochkanov Sergey

=head2 Obsolete function, we recommend to use SpearmanCorr2().

  double spearmanrankcorrelation(const real_1d_array &x, const real_1d_array &y, const ae_int_t n);

      -- ALGLIB --
      Copyright 09.04.2007 by Bochkanov Sergey

=head2 Pearson's correlation coefficient significance test

  void pearsoncorrelationsignificance(const double r, const ae_int_t n, double &bothtails, double &lefttail, double &righttail);

  This test checks hypotheses about whether X  and  Y  are  samples  of  two
  continuous  distributions  having  zero  correlation  or   whether   their
  correlation is non-zero.
  
  The following tests are performed:
      * two-tailed test (null hypothesis - X and Y have zero correlation)
      * left-tailed test (null hypothesis - the correlation  coefficient  is
        greater than or equal to 0)
      * right-tailed test (null hypothesis - the correlation coefficient  is
        less than or equal to 0).
  
  Requirements:
      * the number of elements in each sample is not less than 5
      * normality of distributions of X and Y.
  
  Input parameters:
      R   -   Pearson's correlation coefficient for X and Y
      N   -   number of elements in samples, N>=5.
  
  Output parameters:
      BothTails   -   p-value for two-tailed test.
                      If BothTails is less than the given significance level
                      the null hypothesis is rejected.
      LeftTail    -   p-value for left-tailed test.
                      If LeftTail is less than the given significance level,
                      the null hypothesis is rejected.
      RightTail   -   p-value for right-tailed test.
                      If RightTail is less than the given significance level
                      the null hypothesis is rejected.
  
    -- ALGLIB --
       Copyright 09.04.2007 by Bochkanov Sergey

=head2 Spearman's rank correlation coefficient significance test

  void spearmanrankcorrelationsignificance(const double r, const ae_int_t n, double &bothtails, double &lefttail, double &righttail);

  This test checks hypotheses about whether X  and  Y  are  samples  of  two
  continuous  distributions  having  zero  correlation  or   whether   their
  correlation is non-zero.
  
  The following tests are performed:
      * two-tailed test (null hypothesis - X and Y have zero correlation)
      * left-tailed test (null hypothesis - the correlation  coefficient  is
        greater than or equal to 0)
      * right-tailed test (null hypothesis - the correlation coefficient  is
        less than or equal to 0).
  
  Requirements:
      * the number of elements in each sample is not less than 5.
  
  The test is non-parametric and doesn't require distributions X and Y to be
  normal.
  
  Input parameters:
      R   -   Spearman's rank correlation coefficient for X and Y
      N   -   number of elements in samples, N>=5.
  
  Output parameters:
      BothTails   -   p-value for two-tailed test.
                      If BothTails is less than the given significance level
                      the null hypothesis is rejected.
      LeftTail    -   p-value for left-tailed test.
                      If LeftTail is less than the given significance level,
                      the null hypothesis is rejected.
      RightTail   -   p-value for right-tailed test.
                      If RightTail is less than the given significance level
                      the null hypothesis is rejected.
  
    -- ALGLIB --
       Copyright 09.04.2007 by Bochkanov Sergey

=head2 Jarque-Bera test

  void jarqueberatest(const real_1d_array &x, const ae_int_t n, double &p);

  This test checks hypotheses about the fact that a  given  sample  X  is  a
  sample of normal random variable.
  
  Requirements:
      * the number of elements in the sample is not less than 5.
  
  Input parameters:
      X   -   sample. Array whose index goes from 0 to N-1.
      N   -   size of the sample. N>=5
  
  Output parameters:
      BothTails   -   p-value for two-tailed test.
                      If BothTails is less than the given significance level
                      the null hypothesis is rejected.
      LeftTail    -   p-value for left-tailed test.
                      If LeftTail is less than the given significance level,
                      the null hypothesis is rejected.
      RightTail   -   p-value for right-tailed test.
                      If RightTail is less than the given significance level
                      the null hypothesis is rejected.
  
  Accuracy of the approximation used (5<=N<=1951):
  
  p-value  	    relative error (5<=N<=1951)
  [1, 0.1]            < 1%
  [0.1, 0.01]         < 2%
  [0.01, 0.001]       < 6%
  [0.001, 0]          wasn't measured
  
  For N>1951 accuracy wasn't measured but it shouldn't be sharply  different
  from table values.
  
    -- ALGLIB --
       Copyright 09.04.2007 by Bochkanov Sergey

=head2 Mann-Whitney U-test

  void mannwhitneyutest(const real_1d_array &x, const ae_int_t n, const real_1d_array &y, const ae_int_t m, double &bothtails, double &lefttail, double &righttail);

  This test checks hypotheses about whether X  and  Y  are  samples  of  two
  continuous distributions of the same shape  and  same  median  or  whether
  their medians are different.
  
  The following tests are performed:
      * two-tailed test (null hypothesis - the medians are equal)
      * left-tailed test (null hypothesis - the median of the  first  sample
        is greater than or equal to the median of the second sample)
      * right-tailed test (null hypothesis - the median of the first  sample
        is less than or equal to the median of the second sample).
  
  Requirements:
      * the samples are independent
      * X and Y are continuous distributions (or discrete distributions well-
        approximating continuous distributions)
      * distributions of X and Y have the  same  shape.  The  only  possible
        difference is their position (i.e. the value of the median)
      * the number of elements in each sample is not less than 5
      * the scale of measurement should be ordinal, interval or ratio  (i.e.
        the test could not be applied to nominal variables).
  
  The test is non-parametric and doesn't require distributions to be normal.
  
  Input parameters:
      X   -   sample 1. Array whose index goes from 0 to N-1.
      N   -   size of the sample. N>=5
      Y   -   sample 2. Array whose index goes from 0 to M-1.
      M   -   size of the sample. M>=5
  
  Output parameters:
      BothTails   -   p-value for two-tailed test.
                      If BothTails is less than the given significance level
                      the null hypothesis is rejected.
      LeftTail    -   p-value for left-tailed test.
                      If LeftTail is less than the given significance level,
                      the null hypothesis is rejected.
      RightTail   -   p-value for right-tailed test.
                      If RightTail is less than the given significance level
                      the null hypothesis is rejected.
  
  To calculate p-values, special approximation is used. This method lets  us
  calculate p-values with satisfactory  accuracy  in  interval  [0.0001, 1].
  There is no approximation outside the [0.0001, 1] interval. Therefore,  if
  the significance level outlies this interval, the test returns 0.0001.
  
  Relative precision of approximation of p-value:
  
  N          M          Max.err.   Rms.err.
  5..10      N..10      1.4e-02    6.0e-04
  5..10      N..100     2.2e-02    5.3e-06
  10..15     N..15      1.0e-02    3.2e-04
  10..15     N..100     1.0e-02    2.2e-05
  15..100    N..100     6.1e-03    2.7e-06
  
  For N,M>100 accuracy checks weren't put into  practice,  but  taking  into
  account characteristics of asymptotic approximation used, precision should
  not be sharply different from the values for interval [5, 100].
  
    -- ALGLIB --
       Copyright 09.04.2007 by Bochkanov Sergey

=head2 Sign test

  void onesamplesigntest(const real_1d_array &x, const ae_int_t n, const double median, double &bothtails, double &lefttail, double &righttail);

  This test checks three hypotheses about the median of  the  given  sample.
  The following tests are performed:
      * two-tailed test (null hypothesis - the median is equal to the  given
        value)
      * left-tailed test (null hypothesis - the median is  greater  than  or
        equal to the given value)
      * right-tailed test (null hypothesis - the  median  is  less  than  or
        equal to the given value)
  
  Requirements:
      * the scale of measurement should be ordinal, interval or ratio  (i.e.
        the test could not be applied to nominal variables).
  
  The test is non-parametric and doesn't require distribution X to be normal
  
  Input parameters:
      X       -   sample. Array whose index goes from 0 to N-1.
      N       -   size of the sample.
      Median  -   assumed median value.
  
  Output parameters:
      BothTails   -   p-value for two-tailed test.
                      If BothTails is less than the given significance level
                      the null hypothesis is rejected.
      LeftTail    -   p-value for left-tailed test.
                      If LeftTail is less than the given significance level,
                      the null hypothesis is rejected.
      RightTail   -   p-value for right-tailed test.
                      If RightTail is less than the given significance level
                      the null hypothesis is rejected.
  
  While   calculating   p-values   high-precision   binomial    distribution
  approximation is used, so significance levels have about 15 exact digits.
  
    -- ALGLIB --
       Copyright 08.09.2006 by Bochkanov Sergey

=head2 One-sample t-test

  void studentttest1(const real_1d_array &x, const ae_int_t n, const double mean, double &bothtails, double &lefttail, double &righttail);

  This test checks three hypotheses about the mean of the given sample.  The
  following tests are performed:
      * two-tailed test (null hypothesis - the mean is equal  to  the  given
        value)
      * left-tailed test (null hypothesis - the  mean  is  greater  than  or
        equal to the given value)
      * right-tailed test (null hypothesis - the mean is less than or  equal
        to the given value).
  
  The test is based on the assumption that  a  given  sample  has  a  normal
  distribution and  an  unknown  dispersion.  If  the  distribution  sharply
  differs from normal, the test will work incorrectly.
  
  INPUT PARAMETERS:
      X       -   sample. Array whose index goes from 0 to N-1.
      N       -   size of sample, N>=0
      Mean    -   assumed value of the mean.
  
  OUTPUT PARAMETERS:
      BothTails   -   p-value for two-tailed test.
                      If BothTails is less than the given significance level
                      the null hypothesis is rejected.
      LeftTail    -   p-value for left-tailed test.
                      If LeftTail is less than the given significance level,
                      the null hypothesis is rejected.
      RightTail   -   p-value for right-tailed test.
                      If RightTail is less than the given significance level
                      the null hypothesis is rejected.
  
  NOTE: this function correctly handles degenerate cases:
        * when N=0, all p-values are set to 1.0
        * when variance of X[] is exactly zero, p-values are set
          to 1.0 or 0.0, depending on difference between sample mean and
          value of mean being tested.
  
  
    -- ALGLIB --
       Copyright 08.09.2006 by Bochkanov Sergey

=head2 Two-sample pooled test

  void studentttest2(const real_1d_array &x, const ae_int_t n, const real_1d_array &y, const ae_int_t m, double &bothtails, double &lefttail, double &righttail);

  This test checks three hypotheses about the mean of the given samples. The
  following tests are performed:
      * two-tailed test (null hypothesis - the means are equal)
      * left-tailed test (null hypothesis - the mean of the first sample  is
        greater than or equal to the mean of the second sample)
      * right-tailed test (null hypothesis - the mean of the first sample is
        less than or equal to the mean of the second sample).
  
  Test is based on the following assumptions:
      * given samples have normal distributions
      * dispersions are equal
      * samples are independent.
  
  Input parameters:
      X       -   sample 1. Array whose index goes from 0 to N-1.
      N       -   size of sample.
      Y       -   sample 2. Array whose index goes from 0 to M-1.
      M       -   size of sample.
  
  Output parameters:
      BothTails   -   p-value for two-tailed test.
                      If BothTails is less than the given significance level
                      the null hypothesis is rejected.
      LeftTail    -   p-value for left-tailed test.
                      If LeftTail is less than the given significance level,
                      the null hypothesis is rejected.
      RightTail   -   p-value for right-tailed test.
                      If RightTail is less than the given significance level
                      the null hypothesis is rejected.
  
  NOTE: this function correctly handles degenerate cases:
        * when N=0 or M=0, all p-values are set to 1.0
        * when both samples has exactly zero variance, p-values are set
          to 1.0 or 0.0, depending on difference between means.
  
    -- ALGLIB --
       Copyright 18.09.2006 by Bochkanov Sergey

=head2 Two-sample unpooled test

  void unequalvariancettest(const real_1d_array &x, const ae_int_t n, const real_1d_array &y, const ae_int_t m, double &bothtails, double &lefttail, double &righttail);

  This test checks three hypotheses about the mean of the given samples. The
  following tests are performed:
      * two-tailed test (null hypothesis - the means are equal)
      * left-tailed test (null hypothesis - the mean of the first sample  is
        greater than or equal to the mean of the second sample)
      * right-tailed test (null hypothesis - the mean of the first sample is
        less than or equal to the mean of the second sample).
  
  Test is based on the following assumptions:
      * given samples have normal distributions
      * samples are independent.
  Equality of variances is NOT required.
  
  Input parameters:
      X - sample 1. Array whose index goes from 0 to N-1.
      N - size of the sample.
      Y - sample 2. Array whose index goes from 0 to M-1.
      M - size of the sample.
  
  Output parameters:
      BothTails   -   p-value for two-tailed test.
                      If BothTails is less than the given significance level
                      the null hypothesis is rejected.
      LeftTail    -   p-value for left-tailed test.
                      If LeftTail is less than the given significance level,
                      the null hypothesis is rejected.
      RightTail   -   p-value for right-tailed test.
                      If RightTail is less than the given significance level
                      the null hypothesis is rejected.
  
  NOTE: this function correctly handles degenerate cases:
        * when N=0 or M=0, all p-values are set to 1.0
        * when both samples has zero variance, p-values are set
          to 1.0 or 0.0, depending on difference between means.
        * when only one sample has zero variance, test reduces to 1-sample
          version.
  
    -- ALGLIB --
       Copyright 18.09.2006 by Bochkanov Sergey

=head2 Two-sample F-test

  void ftest(const real_1d_array &x, const ae_int_t n, const real_1d_array &y, const ae_int_t m, double &bothtails, double &lefttail, double &righttail);

  This test checks three hypotheses about dispersions of the given  samples.
  The following tests are performed:
      * two-tailed test (null hypothesis - the dispersions are equal)
      * left-tailed test (null hypothesis  -  the  dispersion  of  the first
        sample is greater than or equal to  the  dispersion  of  the  second
        sample).
      * right-tailed test (null hypothesis - the  dispersion  of  the  first
        sample is less than or equal to the dispersion of the second sample)
  
  The test is based on the following assumptions:
      * the given samples have normal distributions
      * the samples are independent.
  
  Input parameters:
      X   -   sample 1. Array whose index goes from 0 to N-1.
      N   -   sample size.
      Y   -   sample 2. Array whose index goes from 0 to M-1.
      M   -   sample size.
  
  Output parameters:
      BothTails   -   p-value for two-tailed test.
                      If BothTails is less than the given significance level
                      the null hypothesis is rejected.
      LeftTail    -   p-value for left-tailed test.
                      If LeftTail is less than the given significance level,
                      the null hypothesis is rejected.
      RightTail   -   p-value for right-tailed test.
                      If RightTail is less than the given significance level
                      the null hypothesis is rejected.
  
    -- ALGLIB --
       Copyright 19.09.2006 by Bochkanov Sergey

=head2 One-sample chi-square test

  void onesamplevariancetest(const real_1d_array &x, const ae_int_t n, const double variance, double &bothtails, double &lefttail, double &righttail);

  This test checks three hypotheses about the dispersion of the given sample
  The following tests are performed:
      * two-tailed test (null hypothesis - the dispersion equals  the  given
        number)
      * left-tailed test (null hypothesis - the dispersion is  greater  than
        or equal to the given number)
      * right-tailed test (null hypothesis  -  dispersion is  less  than  or
        equal to the given number).
  
  Test is based on the following assumptions:
      * the given sample has a normal distribution.
  
  Input parameters:
      X           -   sample 1. Array whose index goes from 0 to N-1.
      N           -   size of the sample.
      Variance    -   dispersion value to compare with.
  
  Output parameters:
      BothTails   -   p-value for two-tailed test.
                      If BothTails is less than the given significance level
                      the null hypothesis is rejected.
      LeftTail    -   p-value for left-tailed test.
                      If LeftTail is less than the given significance level,
                      the null hypothesis is rejected.
      RightTail   -   p-value for right-tailed test.
                      If RightTail is less than the given significance level
                      the null hypothesis is rejected.
  
    -- ALGLIB --
       Copyright 19.09.2006 by Bochkanov Sergey

=head2 Wilcoxon signed-rank test

  void wilcoxonsignedranktest(const real_1d_array &x, const ae_int_t n, const double e, double &bothtails, double &lefttail, double &righttail);

  This test checks three hypotheses about the median  of  the  given sample.
  The following tests are performed:
      * two-tailed test (null hypothesis - the median is equal to the  given
        value)
      * left-tailed test (null hypothesis - the median is  greater  than  or
        equal to the given value)
      * right-tailed test (null hypothesis  -  the  median  is  less than or
        equal to the given value)
  
  Requirements:
      * the scale of measurement should be ordinal, interval or  ratio (i.e.
        the test could not be applied to nominal variables).
      * the distribution should be continuous and symmetric relative to  its
        median.
      * number of distinct values in the X array should be greater than 4
  
  The test is non-parametric and doesn't require distribution X to be normal
  
  Input parameters:
      X       -   sample. Array whose index goes from 0 to N-1.
      N       -   size of the sample.
      Median  -   assumed median value.
  
  Output parameters:
      BothTails   -   p-value for two-tailed test.
                      If BothTails is less than the given significance level
                      the null hypothesis is rejected.
      LeftTail    -   p-value for left-tailed test.
                      If LeftTail is less than the given significance level,
                      the null hypothesis is rejected.
      RightTail   -   p-value for right-tailed test.
                      If RightTail is less than the given significance level
                      the null hypothesis is rejected.
  
  To calculate p-values, special approximation is used. This method lets  us
  calculate p-values with two decimal places in interval [0.0001, 1].
  
  "Two decimal places" does not sound very impressive, but in  practice  the
  relative error of less than 1% is enough to make a decision.
  
  There is no approximation outside the [0.0001, 1] interval. Therefore,  if
  the significance level outlies this interval, the test returns 0.0001.
  
    -- ALGLIB --
       Copyright 08.09.2006 by Bochkanov Sergey


=head1 SEE ALSO

L<Math::AlgLib>

L<http://www.alglib.net/>

L<ExtUtils::XSpp>

=head1 AUTHOR

Author of the wrapper Perl module is:

Steffen Mueller, E<lt>smueller@cpan.orgE<gt>

But the heavy lifting is done by the C++ ALGLIB library.
See the ALGLIB website (L<http://www.alglib.net/>)
for details on its author(s).

=head1 COPYRIGHT AND LICENSE

The Math::Alglib module is distributed under the same license as the
underlying ALGLIB C++ library. The wrapper code is:

  Copyright (C) 2011, 2012, 2013, 2015 by Steffen Mueller
  
  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation (www.fsf.org); either version 2 of the
  License, or (at your option) any later version.
  
  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.
  
  A copy of the GNU General Public License is available at
  http://www.fsf.org/licensing/licenses

The enclosed copy of the ALGLIB library is licensed as:

  Copyright (c) Sergey Bochkanov (ALGLIB project).
  
  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation (www.fsf.org); either version 2 of the
  License, or (at your option) any later version.
  
  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.
  
  A copy of the GNU General Public License is available at
  http://www.fsf.org/licensing/licenses

=cut
