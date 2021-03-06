use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME => 'PagSeguro::Consulta::Transacao',
    AUTHOR =>
      q{Daniel de Oliveira Mantovani <daniel.oliveira.mantovani@gmail.com>},
    VERSION_FROM  => 'lib/PagSeguro/Consulta/Transacao.pm',
    ABSTRACT_FROM => 'lib/PagSeguro/Consulta/Transacao.pm',
    ( $ExtUtils::MakeMaker::VERSION >= 6.3002
        ? ( 'LICENSE' => 'perl' )
        : () ),
    PL_FILES  => {},
    PREREQ_PM => {
        'Test::More' => 0,
        DateTime     => 0,
        LWP          => 0,
        'Class::C3'  => 0,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES    => 'PagSeguro-Consulta-Transacao-*' },
);
