#!/usr/bin/perl -w
use strict;
use Module::Build::WithXSpp;

my $build = Module::Build::WithXSpp->new(
  module_name     => 'Math::Alglib',
  license         => 'perl',
  requires        => {
  },
  build_requires        => {
    'ExtUtils::ParseXS' => '3.15',
    'ExtUtils::XSpp' => '0.1604',
  },
  # Provides extra C typemaps for opaque objects:
  extra_typemap_modules => {
    'ExtUtils::Typemaps::Default' => '0.01',
  },
);

$build->create_build_script;
