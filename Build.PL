#!/usr/bin/perl -w
use strict;
use Module::Build::WithXSpp;

my $build = Module::Build::WithXSpp->new(
  module_name     => 'Math::Alglib',
  license         => 'perl',
  requires        => {},
  # Provides extra C typemaps for opaque objects:
  extra_typemap_modules => {
    'ExtUtils::Typemaps::Default' => '0.01',
  },
);

$build->create_build_script;
