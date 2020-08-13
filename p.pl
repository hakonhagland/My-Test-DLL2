#! /usr/bin/env perl

use feature qw(say);
use strict;
use warnings;
use ExtUtils::testlib;
use My::Test::DLL2;

#My::Test::DLL2::set_error_handler_off();
My::Test::DLL2::error_edom("EDOM failure");
