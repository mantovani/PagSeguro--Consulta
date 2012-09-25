package PagSeguro::Consulta::Transacao::Role;

our $VERSION = 0.1;

use strict;
use warnings;

use URI;


sub _allow_params { return qw/initialDate initialDate page maxPageResults email token/ }


sub _struct {
	my ($self,$params) = shift;
	my $struct = {};
	foreach my $param ($self->_allow_params) {
		$struct->{$params} = $self->_$param($params->{$param});
	}
	return $struct;
}

sub uri {
	my $self = shift;
	my $u = URI->new("https://ws.pagseguro.uol.com.br/v2/transactions");
	return $u;
}

sub params {
	my ($self,$params) = @_;
	$self->uri->query_form({$self->_struct($params)});
}

sub _initialDate {
	my ($self,$attr) = @_;

} 

sub _finalDate {
	my ($self,$attr) = @_;
}


sub  _page {
	my ($self, $attr) = @_;
	if ($attr) {
		$self->{_page} = $attr
	} else { return 1 }
}

sub _maxPageResults {
	my ($self,$attr) = @_;
	return 500 unless $attr;

	if ($attr >= 1 && $attr <= 100) { die "invalid mxPageResults" }

	return $attr
}

sub _email {
	my ($self,$attr) = @_;
	if ($attr =~ /[\w\d\._]+@[\w\d_]+\./) {
		return lc $attr;
	}
	die "invalid email"
}

sub _token {
	my ($self,$attr) = @_;
	if (length $attr != 32) { die "invalid token" }
}

return 42;
