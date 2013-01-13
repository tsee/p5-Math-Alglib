#!perl
use strict;
use warnings;
use List::Util qw(min first);

mkdir("lib/Math/Alglib");

my $alglib_version = do {open my $fh, "<ALGLIB_VERSION" or die $!; my $x = <$fh>; chomp $x; $x};

my $docs = [
  {
    src_file => 'src/specialfunctions.h',
    mod_name => 'Math::Alglib::SpecialFunctions',
    unimpl   => [qw(lngamma)],
  },
  {
    src_file => 'src/statistics.h',
    mod_name => 'Math::Alglib::Statistics',
  },
];

foreach my $doc (@$docs) {
  my $mod_file = $doc->{mod_name};
  $mod_file =~ s/::/\//g;
  $doc->{mod_file} = "lib/$mod_file.pm";
  open $doc->{mod_fh}, ">", $doc->{mod_file}
    or die $!;

  emit_pm_boilerplate($doc);

  emit_function_docs($doc);

  emit_pm_footer($doc);

  close $doc->{mod_fh};
}

exit();

########################################
sub emit_function_docs {
  my $doc = shift;
  my %unimpl = ( map {$_, undef} @{$doc->{unimpl} || []} );

  open my $fh, "<", $doc->{src_file}
    or die $!;

  my @lines = map {s/[\012\015]+/\n/; $_} <$fh>;
  close $fh;

  my @out;
  # Go through file, search for end-of-function-doc line which
  # looks like '************....*******/'. Check that the next
  # non-empty line is a function signature.
  foreach my $i (0..$#lines) {
    my $line = $lines[$i];
    next if $line !~ /\*{10,}\/\s*$/; # at least 10 * follwed by /
    next if !$lines[$i-1] or $lines[$i-1] =~ /LICENSE/;

    # extract function signatures
    my @siglines;
    foreach my $j ($i+1..$#lines) {
      if ($lines[$j] =~ /;\s*$/) {
        push @siglines, $lines[$j];
      }
      last if @siglines and $lines[$j] !~ /\S/; 
    }
    my $min = min(map length($_), @siglines);
    my $sigline;
    $sigline = first {length($_) == $min} @siglines;
    $sigline =~ /(\w+)\(/ or die $!;
    my $funcname = $1;
    next if exists $unimpl{$funcname}; # skip blacklisted

    # backtrack to start of doc block
    my $j = $i-1;
    --$j while $lines[$j] !~ /^\/\*{10,}/; # look for /********s

    # Generate title
    push @out, "=head2 " . $lines[$j+1] . "\n";
    push @out, "  $sigline\n";
    $j++ if $lines[$j+2] !~ /\S/; # skip title for main doc block
    push @out, map "  $_", @lines[($j+2) .. ($i-1)];
    push @out, "\n";
  }

  my $mfh = $doc->{mod_fh};
  print $mfh @out;
}

########################################
sub emit_pm_footer {
  my $doc = shift;
  my $fh = $doc->{mod_fh};

  print $fh <<HERE;

=head1 SEE ALSO

L<Math::AlgLib>

L<http://www.alglib.net/>

L<ExtUtils::XSpp>

=head1 AUTHOR

Author of the wrapper Perl module is:

Steffen Mueller, E<lt>smueller\@cpan.orgE<gt>

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
} # end emit_pm_footer

###########################################
sub emit_pm_boilerplate {
  my $doc = shift;
  my $fh = $doc->{mod_fh};

  print $fh <<HERE;
package $doc->{mod_name};
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

This module wraps Alglib version $alglib_version.

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
via references. That is equivalent to modifying C<\@_> in Perl.
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

HERE
} # end emit_pm_boilerplate