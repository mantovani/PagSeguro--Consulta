package PagSeguro::Consulta::Transacao;
use Class::C3;

our $VERSION = '0.01';

use 5.006;
use strict;
use warnings;

use base qw/PagSeguro::Consulta::Transacao::Role/;

use PagSeguro::Consulta::Agent;

sub new {
    my $class = shift;
    my $ref   = {
        agent => PagSeguro::Consulta::Agent->new;
    };
    return bless $ref, $class;
}

sub agent { shift->{agent} }

sub fetch {
    my ( $self, $params ) = @_;
    $self->_check_params($params);
    my $url = $self->params($params);
    return $self->agent->request( { method => 'GET', url => $url } );
}

sub _check_params {
    my ( $self, $params ) = @_;
    my %valid = map { $_ => 1 } $self->_allow_params;

    die "invalid params" if keys %{$params} > @valid;

    foreach my $param ( keys %{$params} ) {
        die "invalid param {$param}"
          unless $valid{$param};
    }
}


42;

__END__
=head1 NAME

PagSeguro::Consulta::Transacao - The great new PagSeguro::Consulta::Transacao!

=head1 VERSION

Version 0.01

=cut


=head1 SYNOPSIS

API to interact with L<http://www.pagseguro.com.br>

    use PagSeguro::Consulta::Transacao;

    my $foo = PagSeguro::Consulta::Transacao->new();
    my $xml = $foo->fetch({
		initialDate => 'timestamp',
		finalDate => 'timestamp',
		maxPageResults => 1000,
		email => 'foo@foo.com'
		token => 'your token'
	});

=head1 METHODS

=head1 AUTHOR

Daniel de Oliveira Mantovani, C<< <daniel.oliveira.mantovani at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-pagseguro-consulta-transacao at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=PagSeguro-Consulta-Transacao>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc PagSeguro::Consulta::Transacao


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=PagSeguro-Consulta-Transacao>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/PagSeguro-Consulta-Transacao>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/PagSeguro-Consulta-Transacao>

=item * Search CPAN

L<http://search.cpan.org/dist/PagSeguro-Consulta-Transacao/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2012 Daniel de Oliveira Mantovani.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut
