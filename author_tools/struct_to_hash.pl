#!perl
use strict;
use warnings;

use Getopt::Long qw(GetOptions);
use ExtUtils::Typemaps;
use Data::Dumper;
use File::Spec;

# This is an incredibly naive hack to turn struct definitions in C headers
# into a C function that spits out a hashref with keys like the struct members.

use vars qw($Verbose %SeenUnsupportedTypes);

GetOptions(
  'help|h'            => sub {die "No help. Read the source for now"},
  'file|f=s'          => \(my $infile),
  'struct_name|s=s'   => \(my $struct),
  'struct_fq=s'       => \(my $struct_fq_name),
  'c_to_perl_function|cpfunc=s'
                      => \(my $c_to_perl_funcname),
  'typemap|t=s'       => \(my $typemapfile),
  'verbose|v+'        => \($Verbose),
);

defined $infile && defined $struct
  && defined $c_to_perl_funcname && defined $typemapfile
  or die "Not all require parameters passed";

$struct_fq_name = $struct if not defined $struct_fq_name;

my $c = slurp($infile);

# FIXME obviously super limited
if (not $c =~ / typedef\s+struct\s*\{
                    ([^{}]*?)
                \} \s* \Q$struct\E
              /sx)
{
  die "Cannot find struct in header file";
}
my $content = $1;
$content =~ s/\n/ /g;


my @elems = map {/^(.*)\s+(\S+)/ or die; [$1, $2]}
            map {s/\s+$//; s/^\s+//; $_}
            split /\s*;\s*/, $content;

# Get a complete picture of all typemaps
my $typemap = ExtUtils::Typemaps->new;
$typemap->merge(file => $_, replace => 1) for core_typemap_locations();
$typemap->merge(file => $typemapfile, replace => 1); # local file takes precedence!

my $code = generate_c_to_perl_function_code($c_to_perl_funcname, $struct_fq_name, $typemap, \@elems);
print $code;

exit();

#############################################

sub generate_c_to_perl_function_code {
  my ($funcname, $structname, $typemap, $elems) = @_;
  my $const_struct = const_ref_type($structname);

  my $out = "";
  $out .= <<"HERE";
SV *
$funcname(pTHX_ ${const_struct}strct)
{
  SV *retval;
  HV *hv;
  SV **elem;
  SV *sv;
  hv = newHV();
  retval = newRV_noinc((SV *)hv);

HERE

  foreach my $elem (@$elems) {
    my ($type, $name) = @$elem;
    my $tm = $typemap->get_typemap(ctype => $type);
    if (not defined $tm) {
      if ($Verbose) {
        warn "Unknown type $type in member $name, skipping: " . Dumper($tm);
      }
      else {
        if (not $SeenUnsupportedTypes{$type}++) {
          warn "Skipping unknown C type '$type'.\n";
        }
      }
      next;
    }
    my $outputmap = $typemap->get_outputmap(xstype => $tm->xstype);
    my $o = gen_outputmap_code($outputmap, $type, "sv", "strct.$name", );
    if ($o =~ /\A([ \t]+)/) {
      my $w = $1;
      $o =~ s/^\Q$w\E//gm;
    }
    $o =~ s/^/  /gm;
    $out .= <<"HERE";
  elem = hv_fetchs(hv, "$name", 1); /* 1 => lvalue, O_RDWR|O_CREAT mode, so to speak */
  assert(elem);
  sv = *elem;
HERE
    $out .= $o."\n";
  }

  $out .= <<"HERE";
  return retval;
} /* end of $funcname */
HERE
  
  return $out;
}

sub gen_outputmap_code {
  my ($outmap, $type, $arg, $var) = @_;
  my $cleaned_code .= $outmap->cleaned_code;

  my $out;
  my $eval_code = qq{\$out = "$cleaned_code"; 1};
  eval $eval_code
  or do {
    my $err = $@ || 'Zombie Error';
    die "Failure to evaluate output map: $err";
  };

  return $out;
}


#################################################3
sub slurp {
  my $f = shift;
  open my $fh, "<", $f
    or die "Cannot open input file '$f' for reading: $!";

  local $/;
  my $x = <$fh>;
  close $fh;
  return $x;
}

#################################################3
sub core_typemap_locations {
  my @tm;
  foreach my $dir (@INC) {
    my $file = File::Spec->catfile($dir, ExtUtils => 'typemap');
    push @tm, $file if -e $file;
  }
  return @tm;
}

#################################################3
sub const_ref_type {
  my $struct_type = shift;
  return "const $struct_type \&";
}
