package Perl::Critic::Policy::Reneeb::ProhibitBlockEval;

# ABSTRACT: Do not use the Block-eval. Use Try::Tiny instead

use 5.006001;
use strict;
use warnings;
use Readonly;

use Perl::Critic::Utils qw{ :severities };

use base 'Perl::Critic::Policy';

our $VERSION = '2.04';

#-----------------------------------------------------------------------------

Readonly::Scalar my $DESC => q{Prohibit Block-eval};
Readonly::Scalar my $EXPL => [ 237 ];

#-----------------------------------------------------------------------------

sub default_severity     { return $SEVERITY_MEDIUM           }
sub default_themes       { return qw<reneeb> }
sub applies_to           {
    return qw<
        PPI::Statement
    >;
}

#-----------------------------------------------------------------------------

sub violates {
    my ( $self, $elem, $doc ) = @_;

    # other statements than eval aren't catched
    return if $elem->schild ne 'eval';

    # string eval isn't catched by this policy
    return if !$elem->schild->snext_sibling->isa('PPI::Structure::Block');

    # code uses block-eval
    return $self->violation( $DESC, $EXPL, $elem );
}

1;

__END__

#-----------------------------------------------------------------------------

=pod

=head1 DESCRIPTION

L<Try::Tiny|https://metacpan.org/pod/Try::Tiny> adds some syntactic sugar to your Perl programs.
It avoids some quirks with exception handling that uses C<eval{...}>.

=cut

