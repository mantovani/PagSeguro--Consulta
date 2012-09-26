package PagSeguro::Consulta::Transacao::Role;

use Class::C3;

our $VERSION = 0.1;

use strict;
use warnings;

use URI;
use DateTime;
use Data::Dumper;

sub _allow_params {
    return qw/initialDate finalDate page maxPageResults email token/;
}

sub _struct {
    my ( $self, $params ) = @_;
    my $struct = {};
    foreach my $param ( $self->_allow_params ) {
        my $method = '_' . $param;
        $struct->{$param} = $self->$method( $params->{$param} );
    }
    return $struct;
}

sub params {
    my ( $self, $params ) = @_;
    my $u = URI->new("https://ws.pagseguro.uol.com.br/v2/transactions");
    $u->query_form( $self->_struct($params) );
    return $u->as_string;
}

sub _initialDate {
    my ( $self, $attr ) = @_;
    return $self->_date_format($attr);
}

sub _finalDate {
    my ( $self, $attr ) = @_;
    return $self->_date_format($attr);
}

sub _date_format {
    my ( $self, $timestamp ) = @_;
    my $dt = DateTime->from_epoch( epoch => $timestamp );
    return
        $dt->ymd('-') . 'T'
      . $self->_format_dt( $dt->hour ) . ':'
      . $self->_format_dt( $dt->minute );
}

sub _format_dt {
    my ( $self, $n ) = @_;
    return sprintf( "%02d", $n );
}

sub _page {
    my ( $self, $attr ) = @_;
    if ($attr) {
        $self->{_page} = $attr;
    }
    else { return 1 }
}

sub _maxPageResults {
    my ( $self, $attr ) = @_;
    return 500 unless $attr;

    if ( $attr >= 1 && $attr <= 100 ) { die "invalid mxPageResults" }

    return $attr;
}

sub _email {
    my ( $self, $attr ) = @_;
    if ( $attr =~ /[\w\d\._]+@[\w\d_]+\./ ) {
        return lc $attr;
    }
    die "invalid email";
}

sub _token {
    my ( $self, $attr ) = @_;
    if ( length $attr != 32 ) { die "invalid token" }
    return $attr;
}

return 42;
