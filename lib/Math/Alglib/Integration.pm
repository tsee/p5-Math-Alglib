package Math::Alglib::Integration;
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

This module wraps Alglib version 3.6.0.

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

=head2 Computation of nodes and weights for a Gauss quadrature formula

  void gqgeneraterec(const real_1d_array &alpha, const real_1d_array &beta, const double mu0, const ae_int_t n, ae_int_t &info, real_1d_array &x, real_1d_array &w);

  The algorithm generates the N-point Gauss quadrature formula  with  weight
  function given by coefficients alpha and beta  of  a  recurrence  relation
  which generates a system of orthogonal polynomials:
  
  P-1(x)   =  0
  P0(x)    =  1
  Pn+1(x)  =  (x-alpha(n))*Pn(x)  -  beta(n)*Pn-1(x)
  
  and zeroth moment Mu0
  
  Mu0 = integral(W(x)dx,a,b)
  
  INPUT PARAMETERS:
      Alpha   –   array[0..N-1], alpha coefficients
      Beta    –   array[0..N-1], beta coefficients
                  Zero-indexed element is not used and may be arbitrary.
                  Beta[I]>0.
      Mu0     –   zeroth moment of the weight function.
      N       –   number of nodes of the quadrature formula, N>=1
  
  OUTPUT PARAMETERS:
      Info    -   error code:
                  * -3    internal eigenproblem solver hasn't converged
                  * -2    Beta[i]<=0
                  * -1    incorrect N was passed
                  *  1    OK
      X       -   array[0..N-1] - array of quadrature nodes,
                  in ascending order.
      W       -   array[0..N-1] - array of quadrature weights.
  
    -- ALGLIB --
       Copyright 2005-2009 by Bochkanov Sergey

=head2 Computation of nodes and weights for a Gauss-Lobatto quadrature formula

  void gqgenerategausslobattorec(const real_1d_array &alpha, const real_1d_array &beta, const double mu0, const double a, const double b, const ae_int_t n, ae_int_t &info, real_1d_array &x, real_1d_array &w);

  The algorithm generates the N-point Gauss-Lobatto quadrature formula  with
  weight function given by coefficients alpha and beta of a recurrence which
  generates a system of orthogonal polynomials.
  
  P-1(x)   =  0
  P0(x)    =  1
  Pn+1(x)  =  (x-alpha(n))*Pn(x)  -  beta(n)*Pn-1(x)
  
  and zeroth moment Mu0
  
  Mu0 = integral(W(x)dx,a,b)
  
  INPUT PARAMETERS:
      Alpha   –   array[0..N-2], alpha coefficients
      Beta    –   array[0..N-2], beta coefficients.
                  Zero-indexed element is not used, may be arbitrary.
                  Beta[I]>0
      Mu0     –   zeroth moment of the weighting function.
      A       –   left boundary of the integration interval.
      B       –   right boundary of the integration interval.
      N       –   number of nodes of the quadrature formula, N>=3
                  (including the left and right boundary nodes).
  
  OUTPUT PARAMETERS:
      Info    -   error code:
                  * -3    internal eigenproblem solver hasn't converged
                  * -2    Beta[i]<=0
                  * -1    incorrect N was passed
                  *  1    OK
      X       -   array[0..N-1] - array of quadrature nodes,
                  in ascending order.
      W       -   array[0..N-1] - array of quadrature weights.
  
    -- ALGLIB --
       Copyright 2005-2009 by Bochkanov Sergey

=head2 Computation of nodes and weights for a Gauss-Radau quadrature formula

  void gqgenerategaussradaurec(const real_1d_array &alpha, const real_1d_array &beta, const double mu0, const double a, const ae_int_t n, ae_int_t &info, real_1d_array &x, real_1d_array &w);

  The algorithm generates the N-point Gauss-Radau  quadrature  formula  with
  weight function given by the coefficients alpha and  beta  of a recurrence
  which generates a system of orthogonal polynomials.
  
  P-1(x)   =  0
  P0(x)    =  1
  Pn+1(x)  =  (x-alpha(n))*Pn(x)  -  beta(n)*Pn-1(x)
  
  and zeroth moment Mu0
  
  Mu0 = integral(W(x)dx,a,b)
  
  INPUT PARAMETERS:
      Alpha   –   array[0..N-2], alpha coefficients.
      Beta    –   array[0..N-1], beta coefficients
                  Zero-indexed element is not used.
                  Beta[I]>0
      Mu0     –   zeroth moment of the weighting function.
      A       –   left boundary of the integration interval.
      N       –   number of nodes of the quadrature formula, N>=2
                  (including the left boundary node).
  
  OUTPUT PARAMETERS:
      Info    -   error code:
                  * -3    internal eigenproblem solver hasn't converged
                  * -2    Beta[i]<=0
                  * -1    incorrect N was passed
                  *  1    OK
      X       -   array[0..N-1] - array of quadrature nodes,
                  in ascending order.
      W       -   array[0..N-1] - array of quadrature weights.
  
  
    -- ALGLIB --
       Copyright 2005-2009 by Bochkanov Sergey

=head2 Returns nodes/weights for Gauss-Legendre quadrature on [-1,1] with N

  void gqgenerategausslegendre(const ae_int_t n, ae_int_t &info, real_1d_array &x, real_1d_array &w);

  nodes.
  
  INPUT PARAMETERS:
      N           -   number of nodes, >=1
  
  OUTPUT PARAMETERS:
      Info        -   error code:
                      * -4    an  error   was   detected   when  calculating
                              weights/nodes.  N  is  too  large   to  obtain
                              weights/nodes  with  high   enough   accuracy.
                              Try  to   use   multiple   precision  version.
                      * -3    internal eigenproblem solver hasn't  converged
                      * -1    incorrect N was passed
                      * +1    OK
      X           -   array[0..N-1] - array of quadrature nodes,
                      in ascending order.
      W           -   array[0..N-1] - array of quadrature weights.
  
  
    -- ALGLIB --
       Copyright 12.05.2009 by Bochkanov Sergey

=head2 Returns  nodes/weights  for  Gauss-Jacobi quadrature on [-1,1] with weight

  void gqgenerategaussjacobi(const ae_int_t n, const double alpha, const double beta, ae_int_t &info, real_1d_array &x, real_1d_array &w);

  function W(x)=Power(1-x,Alpha)*Power(1+x,Beta).
  
  INPUT PARAMETERS:
      N           -   number of nodes, >=1
      Alpha       -   power-law coefficient, Alpha>-1
      Beta        -   power-law coefficient, Beta>-1
  
  OUTPUT PARAMETERS:
      Info        -   error code:
                      * -4    an  error  was   detected   when   calculating
                              weights/nodes. Alpha or  Beta  are  too  close
                              to -1 to obtain weights/nodes with high enough
                              accuracy, or, may be, N is too large.  Try  to
                              use multiple precision version.
                      * -3    internal eigenproblem solver hasn't converged
                      * -1    incorrect N/Alpha/Beta was passed
                      * +1    OK
      X           -   array[0..N-1] - array of quadrature nodes,
                      in ascending order.
      W           -   array[0..N-1] - array of quadrature weights.
  
  
    -- ALGLIB --
       Copyright 12.05.2009 by Bochkanov Sergey

=head2 Returns  nodes/weights  for  Gauss-Laguerre  quadrature  on  [0,+inf) with

  void gqgenerategausslaguerre(const ae_int_t n, const double alpha, ae_int_t &info, real_1d_array &x, real_1d_array &w);

  weight function W(x)=Power(x,Alpha)*Exp(-x)
  
  INPUT PARAMETERS:
      N           -   number of nodes, >=1
      Alpha       -   power-law coefficient, Alpha>-1
  
  OUTPUT PARAMETERS:
      Info        -   error code:
                      * -4    an  error  was   detected   when   calculating
                              weights/nodes. Alpha is too  close  to  -1  to
                              obtain weights/nodes with high enough accuracy
                              or, may  be,  N  is  too  large.  Try  to  use
                              multiple precision version.
                      * -3    internal eigenproblem solver hasn't converged
                      * -1    incorrect N/Alpha was passed
                      * +1    OK
      X           -   array[0..N-1] - array of quadrature nodes,
                      in ascending order.
      W           -   array[0..N-1] - array of quadrature weights.
  
  
    -- ALGLIB --
       Copyright 12.05.2009 by Bochkanov Sergey

=head2 Returns  nodes/weights  for  Gauss-Hermite  quadrature on (-inf,+inf) with

  void gqgenerategausshermite(const ae_int_t n, ae_int_t &info, real_1d_array &x, real_1d_array &w);

  weight function W(x)=Exp(-x*x)
  
  INPUT PARAMETERS:
      N           -   number of nodes, >=1
  
  OUTPUT PARAMETERS:
      Info        -   error code:
                      * -4    an  error  was   detected   when   calculating
                              weights/nodes.  May be, N is too large. Try to
                              use multiple precision version.
                      * -3    internal eigenproblem solver hasn't converged
                      * -1    incorrect N/Alpha was passed
                      * +1    OK
      X           -   array[0..N-1] - array of quadrature nodes,
                      in ascending order.
      W           -   array[0..N-1] - array of quadrature weights.
  
  
    -- ALGLIB --
       Copyright 12.05.2009 by Bochkanov Sergey

=head2 Computation of nodes and weights of a Gauss-Kronrod quadrature formula

  void gkqgeneraterec(const real_1d_array &alpha, const real_1d_array &beta, const double mu0, const ae_int_t n, ae_int_t &info, real_1d_array &x, real_1d_array &wkronrod, real_1d_array &wgauss);

  The algorithm generates the N-point Gauss-Kronrod quadrature formula  with
  weight  function  given  by  coefficients  alpha  and beta of a recurrence
  relation which generates a system of orthogonal polynomials:
  
      P-1(x)   =  0
      P0(x)    =  1
      Pn+1(x)  =  (x-alpha(n))*Pn(x)  -  beta(n)*Pn-1(x)
  
  and zero moment Mu0
  
      Mu0 = integral(W(x)dx,a,b)
  
  
  INPUT PARAMETERS:
      Alpha       –   alpha coefficients, array[0..floor(3*K/2)].
      Beta        –   beta coefficients,  array[0..ceil(3*K/2)].
                      Beta[0] is not used and may be arbitrary.
                      Beta[I]>0.
      Mu0         –   zeroth moment of the weight function.
      N           –   number of nodes of the Gauss-Kronrod quadrature formula,
                      N >= 3,
                      N =  2*K+1.
  
  OUTPUT PARAMETERS:
      Info        -   error code:
                      * -5    no real and positive Gauss-Kronrod formula can
                              be created for such a weight function  with  a
                              given number of nodes.
                      * -4    N is too large, task may be ill  conditioned -
                              x[i]=x[i+1] found.
                      * -3    internal eigenproblem solver hasn't converged
                      * -2    Beta[i]<=0
                      * -1    incorrect N was passed
                      * +1    OK
      X           -   array[0..N-1] - array of quadrature nodes,
                      in ascending order.
      WKronrod    -   array[0..N-1] - Kronrod weights
      WGauss      -   array[0..N-1] - Gauss weights (interleaved with zeros
                      corresponding to extended Kronrod nodes).
  
    -- ALGLIB --
       Copyright 08.05.2009 by Bochkanov Sergey

=head2 Returns   Gauss   and   Gauss-Kronrod   nodes/weights  for  Gauss-Legendre

  void gkqgenerategausslegendre(const ae_int_t n, ae_int_t &info, real_1d_array &x, real_1d_array &wkronrod, real_1d_array &wgauss);

  quadrature with N points.
  
  GKQLegendreCalc (calculation) or  GKQLegendreTbl  (precomputed  table)  is
  used depending on machine precision and number of nodes.
  
  INPUT PARAMETERS:
      N           -   number of Kronrod nodes, must be odd number, >=3.
  
  OUTPUT PARAMETERS:
      Info        -   error code:
                      * -4    an  error   was   detected   when  calculating
                              weights/nodes.  N  is  too  large   to  obtain
                              weights/nodes  with  high   enough   accuracy.
                              Try  to   use   multiple   precision  version.
                      * -3    internal eigenproblem solver hasn't converged
                      * -1    incorrect N was passed
                      * +1    OK
      X           -   array[0..N-1] - array of quadrature nodes, ordered in
                      ascending order.
      WKronrod    -   array[0..N-1] - Kronrod weights
      WGauss      -   array[0..N-1] - Gauss weights (interleaved with zeros
                      corresponding to extended Kronrod nodes).
  
  
    -- ALGLIB --
       Copyright 12.05.2009 by Bochkanov Sergey

=head2 Returns   Gauss   and   Gauss-Kronrod   nodes/weights   for   Gauss-Jacobi

  void gkqgenerategaussjacobi(const ae_int_t n, const double alpha, const double beta, ae_int_t &info, real_1d_array &x, real_1d_array &wkronrod, real_1d_array &wgauss);

  quadrature on [-1,1] with weight function
  
      W(x)=Power(1-x,Alpha)*Power(1+x,Beta).
  
  INPUT PARAMETERS:
      N           -   number of Kronrod nodes, must be odd number, >=3.
      Alpha       -   power-law coefficient, Alpha>-1
      Beta        -   power-law coefficient, Beta>-1
  
  OUTPUT PARAMETERS:
      Info        -   error code:
                      * -5    no real and positive Gauss-Kronrod formula can
                              be created for such a weight function  with  a
                              given number of nodes.
                      * -4    an  error  was   detected   when   calculating
                              weights/nodes. Alpha or  Beta  are  too  close
                              to -1 to obtain weights/nodes with high enough
                              accuracy, or, may be, N is too large.  Try  to
                              use multiple precision version.
                      * -3    internal eigenproblem solver hasn't converged
                      * -1    incorrect N was passed
                      * +1    OK
                      * +2    OK, but quadrature rule have exterior  nodes,
                              x[0]<-1 or x[n-1]>+1
      X           -   array[0..N-1] - array of quadrature nodes, ordered in
                      ascending order.
      WKronrod    -   array[0..N-1] - Kronrod weights
      WGauss      -   array[0..N-1] - Gauss weights (interleaved with zeros
                      corresponding to extended Kronrod nodes).
  
  
    -- ALGLIB --
       Copyright 12.05.2009 by Bochkanov Sergey

=head2 Returns Gauss and Gauss-Kronrod nodes for quadrature with N points.

  void gkqlegendrecalc(const ae_int_t n, ae_int_t &info, real_1d_array &x, real_1d_array &wkronrod, real_1d_array &wgauss);

  Reduction to tridiagonal eigenproblem is used.
  
  INPUT PARAMETERS:
      N           -   number of Kronrod nodes, must be odd number, >=3.
  
  OUTPUT PARAMETERS:
      Info        -   error code:
                      * -4    an  error   was   detected   when  calculating
                              weights/nodes.  N  is  too  large   to  obtain
                              weights/nodes  with  high   enough   accuracy.
                              Try  to   use   multiple   precision  version.
                      * -3    internal eigenproblem solver hasn't converged
                      * -1    incorrect N was passed
                      * +1    OK
      X           -   array[0..N-1] - array of quadrature nodes, ordered in
                      ascending order.
      WKronrod    -   array[0..N-1] - Kronrod weights
      WGauss      -   array[0..N-1] - Gauss weights (interleaved with zeros
                      corresponding to extended Kronrod nodes).
  
    -- ALGLIB --
       Copyright 12.05.2009 by Bochkanov Sergey

=head2 Returns Gauss and Gauss-Kronrod nodes for quadrature with N  points  using

  void gkqlegendretbl(const ae_int_t n, real_1d_array &x, real_1d_array &wkronrod, real_1d_array &wgauss, double &eps);

  pre-calculated table. Nodes/weights were  computed  with  accuracy  up  to
  1.0E-32 (if MPFR version of ALGLIB is used). In standard double  precision
  accuracy reduces to something about 2.0E-16 (depending  on your compiler's
  handling of long floating point constants).
  
  INPUT PARAMETERS:
      N           -   number of Kronrod nodes.
                      N can be 15, 21, 31, 41, 51, 61.
  
  OUTPUT PARAMETERS:
      X           -   array[0..N-1] - array of quadrature nodes, ordered in
                      ascending order.
      WKronrod    -   array[0..N-1] - Kronrod weights
      WGauss      -   array[0..N-1] - Gauss weights (interleaved with zeros
                      corresponding to extended Kronrod nodes).
  
  
    -- ALGLIB --
       Copyright 12.05.2009 by Bochkanov Sergey


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

  Copyright (C) 2011, 2012, 2013 by Steffen Mueller
  
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
