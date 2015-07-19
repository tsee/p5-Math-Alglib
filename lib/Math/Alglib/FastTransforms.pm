package Math::Alglib::FastTransforms;
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

=head2 1-dimensional complex FFT.

  void fftc1d(complex_1d_array &a);

  Array size N may be arbitrary number (composite or prime).  Composite  N's
  are handled with cache-oblivious variation of  a  Cooley-Tukey  algorithm.
  Small prime-factors are transformed using hard coded  codelets (similar to
  FFTW codelets, but without low-level  optimization),  large  prime-factors
  are handled with Bluestein's algorithm.
  
  Fastests transforms are for smooth N's (prime factors are 2, 3,  5  only),
  most fast for powers of 2. When N have prime factors  larger  than  these,
  but orders of magnitude smaller than N, computations will be about 4 times
  slower than for nearby highly composite N's. When N itself is prime, speed
  will be 6 times lower.
  
  Algorithm has O(N*logN) complexity for any N (composite or prime).
  
  INPUT PARAMETERS
      A   -   array[0..N-1] - complex function to be transformed
      N   -   problem size
  
  OUTPUT PARAMETERS
      A   -   DFT of a input array, array[0..N-1]
              A_out[j] = SUM(A_in[k]*exp(-2*pi*sqrt(-1)*j*k/N), k = 0..N-1)
  
  
    -- ALGLIB --
       Copyright 29.05.2009 by Bochkanov Sergey

=head2 1-dimensional complex inverse FFT.

  void fftc1dinv(complex_1d_array &a);

  Array size N may be arbitrary number (composite or prime).  Algorithm  has
  O(N*logN) complexity for any N (composite or prime).
  
  See FFTC1D() description for more information about algorithm performance.
  
  INPUT PARAMETERS
      A   -   array[0..N-1] - complex array to be transformed
      N   -   problem size
  
  OUTPUT PARAMETERS
      A   -   inverse DFT of a input array, array[0..N-1]
              A_out[j] = SUM(A_in[k]/N*exp(+2*pi*sqrt(-1)*j*k/N), k = 0..N-1)
  
  
    -- ALGLIB --
       Copyright 29.05.2009 by Bochkanov Sergey

=head2 1-dimensional real FFT.

  void fftr1d(const real_1d_array &a, complex_1d_array &f);

  Algorithm has O(N*logN) complexity for any N (composite or prime).
  
  INPUT PARAMETERS
      A   -   array[0..N-1] - real function to be transformed
      N   -   problem size
  
  OUTPUT PARAMETERS
      F   -   DFT of a input array, array[0..N-1]
              F[j] = SUM(A[k]*exp(-2*pi*sqrt(-1)*j*k/N), k = 0..N-1)
  
  NOTE:
      F[] satisfies symmetry property F[k] = conj(F[N-k]),  so just one half
  of  array  is  usually needed. But for convinience subroutine returns full
  complex array (with frequencies above N/2), so its result may be  used  by
  other FFT-related subroutines.
  
  
    -- ALGLIB --
       Copyright 01.06.2009 by Bochkanov Sergey

=head2 1-dimensional real inverse FFT.

  void fftr1dinv(const complex_1d_array &f, real_1d_array &a);

  Algorithm has O(N*logN) complexity for any N (composite or prime).
  
  INPUT PARAMETERS
      F   -   array[0..floor(N/2)] - frequencies from forward real FFT
      N   -   problem size
  
  OUTPUT PARAMETERS
      A   -   inverse DFT of a input array, array[0..N-1]
  
  NOTE:
      F[] should satisfy symmetry property F[k] = conj(F[N-k]), so just  one
  half of frequencies array is needed - elements from 0 to floor(N/2).  F[0]
  is ALWAYS real. If N is even F[floor(N/2)] is real too. If N is odd,  then
  F[floor(N/2)] has no special properties.
  
  Relying on properties noted above, FFTR1DInv subroutine uses only elements
  from 0th to floor(N/2)-th. It ignores imaginary part of F[0],  and in case
  N is even it ignores imaginary part of F[floor(N/2)] too.
  
  When you call this function using full arguments list - "FFTR1DInv(F,N,A)"
  - you can pass either either frequencies array with N elements or  reduced
  array with roughly N/2 elements - subroutine will  successfully  transform
  both.
  
  If you call this function using reduced arguments list -  "FFTR1DInv(F,A)"
  - you must pass FULL array with N elements (although higher  N/2 are still
  not used) because array size is used to automatically determine FFT length
  
  
    -- ALGLIB --
       Copyright 01.06.2009 by Bochkanov Sergey

=head2 1-dimensional complex convolution.

Note on the Perl wrapper:
The signature for calling from Perl is C<complex_1d_array convc1d(complex_1d_array a, complex_1d_array b)>, so the parameters C<n> and C<m> of the C function (the array lengths) are inferred from the size of the input arrays.

  void convc1d(const complex_1d_array &a, const ae_int_t m, const complex_1d_array &b, const ae_int_t n, complex_1d_array &r);

  For given A/B returns conv(A,B) (non-circular). Subroutine can automatically
  choose between three implementations: straightforward O(M*N)  formula  for
  very small N (or M), overlap-add algorithm for  cases  where  max(M,N)  is
  significantly larger than min(M,N), but O(M*N) algorithm is too slow,  and
  general FFT-based formula for cases where two previois algorithms are  too
  slow.
  
  Algorithm has max(M,N)*log(max(M,N)) complexity for any M/N.
  
  INPUT PARAMETERS
      A   -   array[0..M-1] - complex function to be transformed
      M   -   problem size
      B   -   array[0..N-1] - complex function to be transformed
      N   -   problem size
  
  OUTPUT PARAMETERS
      R   -   convolution: A*B. array[0..N+M-2].
  
  NOTE:
      It is assumed that A is zero at T<0, B is zero too.  If  one  or  both
  functions have non-zero values at negative T's, you  can  still  use  this
  subroutine - just shift its result correspondingly.
  
    -- ALGLIB --
       Copyright 21.07.2009 by Bochkanov Sergey

=head2 1-dimensional complex non-circular deconvolution (inverse of ConvC1D()).

Note on the Perl wrapper:
The signature for calling from Perl is C<complex_1d_array convc1dinv(complex_1d_array a, complex_1d_array b)>, so the parameters C<n> and C<m> of the C function (the array lengths) are inferred from the size of the input arrays.

  void convc1dinv(const complex_1d_array &a, const ae_int_t m, const complex_1d_array &b, const ae_int_t n, complex_1d_array &r);

  Algorithm has M*log(M)) complexity for any M (composite or prime).
  
  INPUT PARAMETERS
      A   -   array[0..M-1] - convolved signal, A = conv(R, B)
      M   -   convolved signal length
      B   -   array[0..N-1] - response
      N   -   response length, N<=M
  
  OUTPUT PARAMETERS
      R   -   deconvolved signal. array[0..M-N].
  
  NOTE:
      deconvolution is unstable process and may result in division  by  zero
  (if your response function is degenerate, i.e. has zero Fourier coefficient).
  
  NOTE:
      It is assumed that A is zero at T<0, B is zero too.  If  one  or  both
  functions have non-zero values at negative T's, you  can  still  use  this
  subroutine - just shift its result correspondingly.
  
    -- ALGLIB --
       Copyright 21.07.2009 by Bochkanov Sergey

=head2 1-dimensional circular complex convolution.

Note on the Perl wrapper:
The signature for calling from Perl is C<complex_1d_array convc1dcircular(complex_1d_array s, complex_1d_array r)>, so the parameters C<n> and C<m> of the C function (the array lengths) are inferred from the size of the input arrays.

  void convc1dcircular(const complex_1d_array &s, const ae_int_t m, const complex_1d_array &r, const ae_int_t n, complex_1d_array &c);

  For given S/R returns conv(S,R) (circular). Algorithm has linearithmic
  complexity for any M/N.
  
  IMPORTANT:  normal convolution is commutative,  i.e.   it  is symmetric  -
  conv(A,B)=conv(B,A).  Cyclic convolution IS NOT.  One function - S - is  a
  signal,  periodic function, and another - R - is a response,  non-periodic
  function with limited length.
  
  INPUT PARAMETERS
      S   -   array[0..M-1] - complex periodic signal
      M   -   problem size
      B   -   array[0..N-1] - complex non-periodic response
      N   -   problem size
  
  OUTPUT PARAMETERS
      R   -   convolution: A*B. array[0..M-1].
  
  NOTE:
      It is assumed that B is zero at T<0. If  it  has  non-zero  values  at
  negative T's, you can still use this subroutine - just  shift  its  result
  correspondingly.
  
    -- ALGLIB --
       Copyright 21.07.2009 by Bochkanov Sergey

=head2 1-dimensional circular complex deconvolution (inverse of ConvC1DCircular()).

Note on the Perl wrapper:
The signature for calling from Perl is C<complex_1d_array convc1dcircularinv(complex_1d_array s, complex_1d_array r)>, so the parameters C<n> and C<m> of the C function (the array lengths) are inferred from the size of the input arrays.

  void convc1dcircularinv(const complex_1d_array &a, const ae_int_t m, const complex_1d_array &b, const ae_int_t n, complex_1d_array &r);

  Algorithm has M*log(M)) complexity for any M (composite or prime).
  
  INPUT PARAMETERS
      A   -   array[0..M-1] - convolved periodic signal, A = conv(R, B)
      M   -   convolved signal length
      B   -   array[0..N-1] - non-periodic response
      N   -   response length
  
  OUTPUT PARAMETERS
      R   -   deconvolved signal. array[0..M-1].
  
  NOTE:
      deconvolution is unstable process and may result in division  by  zero
  (if your response function is degenerate, i.e. has zero Fourier coefficient).
  
  NOTE:
      It is assumed that B is zero at T<0. If  it  has  non-zero  values  at
  negative T's, you can still use this subroutine - just  shift  its  result
  correspondingly.
  
    -- ALGLIB --
       Copyright 21.07.2009 by Bochkanov Sergey

=head2 1-dimensional real convolution.

Note on the Perl wrapper:
The signature for calling from Perl is C<real_1d_array convr1d(real_1d_array a, real_1d_array b)>, so the parameters C<n> and C<m> of the C function (the array lengths) are inferred from the size of the input arrays.

  void convr1d(const real_1d_array &a, const ae_int_t m, const real_1d_array &b, const ae_int_t n, real_1d_array &r);

  Analogous to ConvC1D(), see ConvC1D() comments for more details.
  
  INPUT PARAMETERS
      A   -   array[0..M-1] - real function to be transformed
      M   -   problem size
      B   -   array[0..N-1] - real function to be transformed
      N   -   problem size
  
  OUTPUT PARAMETERS
      R   -   convolution: A*B. array[0..N+M-2].
  
  NOTE:
      It is assumed that A is zero at T<0, B is zero too.  If  one  or  both
  functions have non-zero values at negative T's, you  can  still  use  this
  subroutine - just shift its result correspondingly.
  
    -- ALGLIB --
       Copyright 21.07.2009 by Bochkanov Sergey

=head2 1-dimensional real deconvolution (inverse of ConvC1D()).

Note on the Perl wrapper:
The signature for calling from Perl is C<real_1d_array convr1dinv(real_1d_array a, real_1d_array b)>, so the parameters C<n> and C<m> of the C function (the array lengths) are inferred from the size of the input arrays.

  void convr1dinv(const real_1d_array &a, const ae_int_t m, const real_1d_array &b, const ae_int_t n, real_1d_array &r);

  Algorithm has M*log(M)) complexity for any M (composite or prime).
  
  INPUT PARAMETERS
      A   -   array[0..M-1] - convolved signal, A = conv(R, B)
      M   -   convolved signal length
      B   -   array[0..N-1] - response
      N   -   response length, N<=M
  
  OUTPUT PARAMETERS
      R   -   deconvolved signal. array[0..M-N].
  
  NOTE:
      deconvolution is unstable process and may result in division  by  zero
  (if your response function is degenerate, i.e. has zero Fourier coefficient).
  
  NOTE:
      It is assumed that A is zero at T<0, B is zero too.  If  one  or  both
  functions have non-zero values at negative T's, you  can  still  use  this
  subroutine - just shift its result correspondingly.
  
    -- ALGLIB --
       Copyright 21.07.2009 by Bochkanov Sergey

=head2 1-dimensional circular real convolution.

Note on the Perl wrapper:
The signature for calling from Perl is C<real_1d_array convr1dcircular(real_1d_array s, real_1d_array r)>, so the parameters C<n> and C<m> of the C function (the array lengths) are inferred from the size of the input arrays.

  void convr1dcircular(const real_1d_array &s, const ae_int_t m, const real_1d_array &r, const ae_int_t n, real_1d_array &c);

  Analogous to ConvC1DCircular(), see ConvC1DCircular() comments for more details.
  
  INPUT PARAMETERS
      S   -   array[0..M-1] - real signal
      M   -   problem size
      B   -   array[0..N-1] - real response
      N   -   problem size
  
  OUTPUT PARAMETERS
      R   -   convolution: A*B. array[0..M-1].
  
  NOTE:
      It is assumed that B is zero at T<0. If  it  has  non-zero  values  at
  negative T's, you can still use this subroutine - just  shift  its  result
  correspondingly.
  
    -- ALGLIB --
       Copyright 21.07.2009 by Bochkanov Sergey

=head2 1-dimensional complex deconvolution (inverse of ConvC1D()).

Note on the Perl wrapper:
The signature for calling from Perl is C<real_1d_array convr1dcircularinv(real_1d_array s, real_1d_array r)>, so the parameters C<n> and C<m> of the C function (the array lengths) are inferred from the size of the input arrays.

  void convr1dcircularinv(const real_1d_array &a, const ae_int_t m, const real_1d_array &b, const ae_int_t n, real_1d_array &r);

  Algorithm has M*log(M)) complexity for any M (composite or prime).
  
  INPUT PARAMETERS
      A   -   array[0..M-1] - convolved signal, A = conv(R, B)
      M   -   convolved signal length
      B   -   array[0..N-1] - response
      N   -   response length
  
  OUTPUT PARAMETERS
      R   -   deconvolved signal. array[0..M-N].
  
  NOTE:
      deconvolution is unstable process and may result in division  by  zero
  (if your response function is degenerate, i.e. has zero Fourier coefficient).
  
  NOTE:
      It is assumed that B is zero at T<0. If  it  has  non-zero  values  at
  negative T's, you can still use this subroutine - just  shift  its  result
  correspondingly.
  
    -- ALGLIB --
       Copyright 21.07.2009 by Bochkanov Sergey

=head2 1-dimensional complex cross-correlation.

Note on the Perl wrapper:
The signature for calling from Perl is C<complex_1d_array corrc1d(complex_1d_array signal, complex_1d_array pattern)>, so the parameters C<n> and C<m> of the C function (the array lengths) are inferred from the size of the input arrays.

  void corrc1d(const complex_1d_array &signal, const ae_int_t n, const complex_1d_array &pattern, const ae_int_t m, complex_1d_array &r);

  For given Pattern/Signal returns corr(Pattern,Signal) (non-circular).
  
  Correlation is calculated using reduction to  convolution.  Algorithm with
  max(N,N)*log(max(N,N)) complexity is used (see  ConvC1D()  for  more  info
  about performance).
  
  IMPORTANT:
      for  historical reasons subroutine accepts its parameters in  reversed
      order: CorrC1D(Signal, Pattern) = Pattern x Signal (using  traditional
      definition of cross-correlation, denoting cross-correlation as "x").
  
  INPUT PARAMETERS
      Signal  -   array[0..N-1] - complex function to be transformed,
                  signal containing pattern
      N       -   problem size
      Pattern -   array[0..M-1] - complex function to be transformed,
                  pattern to search withing signal
      M       -   problem size
  
  OUTPUT PARAMETERS
      R       -   cross-correlation, array[0..N+M-2]:
                  * positive lags are stored in R[0..N-1],
                    R[i] = sum(conj(pattern[j])*signal[i+j]
                  * negative lags are stored in R[N..N+M-2],
                    R[N+M-1-i] = sum(conj(pattern[j])*signal[-i+j]
  
  NOTE:
      It is assumed that pattern domain is [0..M-1].  If Pattern is non-zero
  on [-K..M-1],  you can still use this subroutine, just shift result by K.
  
    -- ALGLIB --
       Copyright 21.07.2009 by Bochkanov Sergey

=head2 1-dimensional circular complex cross-correlation.

Note on the Perl wrapper:
The signature for calling from Perl is C<complex_1d_array corrc1dcircular(complex_1d_array signal, complex_1d_array pattern)>, so the parameters C<n> and C<m> of the C function (the array lengths) are inferred from the size of the input arrays.

  void corrc1dcircular(const complex_1d_array &signal, const ae_int_t m, const complex_1d_array &pattern, const ae_int_t n, complex_1d_array &c);

  For given Pattern/Signal returns corr(Pattern,Signal) (circular).
  Algorithm has linearithmic complexity for any M/N.
  
  IMPORTANT:
      for  historical reasons subroutine accepts its parameters in  reversed
      order:   CorrC1DCircular(Signal, Pattern) = Pattern x Signal    (using
      traditional definition of cross-correlation, denoting cross-correlation
      as "x").
  
  INPUT PARAMETERS
      Signal  -   array[0..N-1] - complex function to be transformed,
                  periodic signal containing pattern
      N       -   problem size
      Pattern -   array[0..M-1] - complex function to be transformed,
                  non-periodic pattern to search withing signal
      M       -   problem size
  
  OUTPUT PARAMETERS
      R   -   convolution: A*B. array[0..M-1].
  
  
    -- ALGLIB --
       Copyright 21.07.2009 by Bochkanov Sergey

=head2 1-dimensional real cross-correlation.

Note on the Perl wrapper:
The signature for calling from Perl is C<real_1d_array corrr1d(real_1d_array signal, real_1d_array pattern)>, so the parameters C<n> and C<m> of the C function (the array lengths) are inferred from the size of the input arrays.

  void corrr1d(const real_1d_array &signal, const ae_int_t n, const real_1d_array &pattern, const ae_int_t m, real_1d_array &r);

  For given Pattern/Signal returns corr(Pattern,Signal) (non-circular).
  
  Correlation is calculated using reduction to  convolution.  Algorithm with
  max(N,N)*log(max(N,N)) complexity is used (see  ConvC1D()  for  more  info
  about performance).
  
  IMPORTANT:
      for  historical reasons subroutine accepts its parameters in  reversed
      order: CorrR1D(Signal, Pattern) = Pattern x Signal (using  traditional
      definition of cross-correlation, denoting cross-correlation as "x").
  
  INPUT PARAMETERS
      Signal  -   array[0..N-1] - real function to be transformed,
                  signal containing pattern
      N       -   problem size
      Pattern -   array[0..M-1] - real function to be transformed,
                  pattern to search withing signal
      M       -   problem size
  
  OUTPUT PARAMETERS
      R       -   cross-correlation, array[0..N+M-2]:
                  * positive lags are stored in R[0..N-1],
                    R[i] = sum(pattern[j]*signal[i+j]
                  * negative lags are stored in R[N..N+M-2],
                    R[N+M-1-i] = sum(pattern[j]*signal[-i+j]
  
  NOTE:
      It is assumed that pattern domain is [0..M-1].  If Pattern is non-zero
  on [-K..M-1],  you can still use this subroutine, just shift result by K.
  
    -- ALGLIB --
       Copyright 21.07.2009 by Bochkanov Sergey

=head2 1-dimensional circular real cross-correlation.

Note on the Perl wrapper:
The signature for calling from Perl is C<real_1d_array corrr1dcircular(real_1d_array signal, real_1d_array pattern)>, so the parameters C<n> and C<m> of the C function (the array lengths) are inferred from the size of the input arrays.

  void corrr1dcircular(const real_1d_array &signal, const ae_int_t m, const real_1d_array &pattern, const ae_int_t n, real_1d_array &c);

  For given Pattern/Signal returns corr(Pattern,Signal) (circular).
  Algorithm has linearithmic complexity for any M/N.
  
  IMPORTANT:
      for  historical reasons subroutine accepts its parameters in  reversed
      order:   CorrR1DCircular(Signal, Pattern) = Pattern x Signal    (using
      traditional definition of cross-correlation, denoting cross-correlation
      as "x").
  
  INPUT PARAMETERS
      Signal  -   array[0..N-1] - real function to be transformed,
                  periodic signal containing pattern
      N       -   problem size
      Pattern -   array[0..M-1] - real function to be transformed,
                  non-periodic pattern to search withing signal
      M       -   problem size
  
  OUTPUT PARAMETERS
      R   -   convolution: A*B. array[0..M-1].
  
  
    -- ALGLIB --
       Copyright 21.07.2009 by Bochkanov Sergey

=head2 1-dimensional Fast Hartley Transform.

  void fhtr1d(real_1d_array &a, const ae_int_t n);

  Algorithm has O(N*logN) complexity for any N (composite or prime).
  
  INPUT PARAMETERS
      A   -   array[0..N-1] - real function to be transformed
      N   -   problem size
  
  OUTPUT PARAMETERS
      A   -   FHT of a input array, array[0..N-1],
              A_out[k] = sum(A_in[j]*(cos(2*pi*j*k/N)+sin(2*pi*j*k/N)), j=0..N-1)
  
  
    -- ALGLIB --
       Copyright 04.06.2009 by Bochkanov Sergey

=head2 1-dimensional inverse FHT.

  void fhtr1dinv(real_1d_array &a, const ae_int_t n);

  Algorithm has O(N*logN) complexity for any N (composite or prime).
  
  INPUT PARAMETERS
      A   -   array[0..N-1] - complex array to be transformed
      N   -   problem size
  
  OUTPUT PARAMETERS
      A   -   inverse FHT of a input array, array[0..N-1]
  
  
    -- ALGLIB --
       Copyright 29.05.2009 by Bochkanov Sergey


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
