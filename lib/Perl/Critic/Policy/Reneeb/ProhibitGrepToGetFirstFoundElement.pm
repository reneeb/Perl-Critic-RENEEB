package Perl::Critic::Policy::Reneeb::ProhibitGrepToGetFirstFoundElement;

# ABSTRACT: Use List::Utils 'first' instead of grep if you want to get the first found element

use 5.006001;
use strict;
use warnings;
use Readonly;
use List::Util qw(first);

use Perl::Critic::Utils qw{ :severities };

use base 'Perl::Critic::Policy';

our $VERSION = '2.05';

#-----------------------------------------------------------------------------

Readonly::Scalar my $DESC => q{Use List::Utils 'first' instead of grep if you want to get the first found element};
Readonly::Scalar my $EXPL => [  ];

#-----------------------------------------------------------------------------

sub default_severity     { return $SEVERITY_MEDIUM           }
sub default_themes       { return qw<reneeb> }
sub applies_to           {
    return qw<
        PPI::Token::Word
    >;
}

#-----------------------------------------------------------------------------

sub violates {
    my ( $self, $elem, $doc ) = @_;

    # other statements than grep aren't catched
    return if $elem->content ne 'grep';

    my $parent = $elem->parent;

    # grep in boolean or void context isn't checked
    return if !$parent->isa('PPI::Statement::Variable');

    my $list = first{ $_->isa('PPI::Structure::List') } $parent->schildren;
    return if !$list;

    my $symbols = $list->find('PPI::Token::Symbol');
    
    return if !$symbols;
    return if 1 != @{ $symbols };

    return if '$' ne substr $symbols->[0], 0, 1;

    return $self->violation( $DESC, $EXPL, $elem );
}

1;

__END__

#-----------------------------------------------------------------------------

=pod

=head1 DESCRIPTION

To get the first element of a list that matches some criteria, List::Util's C<first>
should be used instead of C<grep>.

=cut

