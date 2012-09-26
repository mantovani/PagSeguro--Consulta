package PagSeguro::Consulta::Agent;

our $VERSION = 0.1;

use strict;
use warnings;

use LWP::UserAgent;
use HTTP::Request;
use Data::Dumper;

sub new {
    my $class = shift;

    # Agent
    my $ua = LWP::UserAgent->new;

    my $ref = {
        agent   => $ua,
        methods => { post => 1, get => 1 },
    };
    return bless $ref, $class;
}

sub agent   { shift->{agent} }
sub methods { shift->{methods} }

sub request {
    my ( $self, $struct ) = @_;
    if ( $self->methods->{ lc $struct->{method} } ) {
        my $req = HTTP::Request->new( $struct->{method} => $struct->{url} );
        my $res = $self->agent->request($req);
        if ( $res->is_success ) {
            return $res->decoded_content;
        }
        else { print Dumper $res->content; die "not success in fetch the url" }
    }
    else { die "invalid method, just allow post or get" }
}

42;
__END__


=head2 ATTRIBUTES

=head2 agent

LWP::UserAgent class

=head2 methods

Allowed methods to B<request> I<POST> and I<GET>

=head1 METHODS

=head2 new

instance  the class.

=head2 request

	$instance->request({url => 'http://foo.com', method => 'GET'})

Request the "url" and return the content, the method can be only 'GET' or 'POST'.
