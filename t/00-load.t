#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'SIFTS' ) || print "Bail out!\n";
}

diag( "Testing SIFTS $SIFTS::VERSION, Perl $], $^X" );
