#!perl
use strict;
use warnings;

mkdir("lib/Math/Alglib");
open my $fh, ">", "lib/Math/Alglib/SpecialFunctions.pod" or die $!;

print $fh <<'HERE';
=head1 NAME

Math::Alglib::SpecialFunctions - Alglib special functions wrapper

=head1 DESCRIPTION

Wrapping the special functions found in Alglib. This documentation is
auto-generated from the F<specialfunctions.h> header file. If in doubt,
refer to the header file.

For each function, the C++ signature is included in the documentation
below. The Perl wrappers may work slightly differently. Generally speaking:

=over 2

=item *

C<ptrdiff_t> is to be consider a (signed) integer.

=item *

Functions of the form C<void foo(double bar, double &baz)> are
using the C++-style of passing output parameters in via references.
The Perl calling convention for these functions becomes:

  double foo(double bar)

where the return value is C<baz>. If there are multiple output
parameters, the return value will be a reference to an array
instead of returning a list.

=item *

The types C<real_1d_array> and C<real_2d_array> are converted to/from
Perl array references and nested Perl array references respectively.

=back

=head1 FUNCTIONS

HERE

close $fh;

system(q{perl -ne 'push @l, $_;END{ for $i (0..$#l) { if ($l[$i] =~ /\*{10,}\/\s*$/ and $l[$i+1] =~ /;\s*$/){ my $j = $i-1; --$j while ($l[$j] !~ /^\/\*{10,}/); print "=head3 " . $l[$j+1] . "\n"; print "  " . $l[$i+1] . "\n"; $j++ if $l[$j+2] !~ /\S/; print map "  $_", @l[($j+2) .. ($i-1)]; print "\n"; } } }' src/specialfunctions.h >> lib/Math/Alglib/SpecialFunctions.pod});

open $fh, ">>", "lib/Math/Alglib/SpecialFunctions.pod" or die $!;
print $fh <<'HERE';

=head1 SEE ALSO

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
HERE
