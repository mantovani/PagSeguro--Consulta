#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'PagSeguro::Consulta::Transacao' ) || print "Bail out!\n";
}

diag( "Testing PagSeguro::Consulta::Transacao $PagSeguro::Consulta::Transacao::VERSION, Perl $], $^X" );
