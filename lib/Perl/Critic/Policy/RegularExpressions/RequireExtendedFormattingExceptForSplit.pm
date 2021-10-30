package Perl::Critic::Policy::RegularExpressions::RequireExtendedFormattingExceptForSplit;

# ABSTRACT: Always use the C</x> modifier with regular expressions, except when the regex is used as the first argument of C<split>

use 5.006001;
use strict;
use warnings;
use Readonly;

use Perl::Critic::Utils qw{ :severities };

use base 'Perl::Critic::Policy';

our $VERSION = '2.05';

#-----------------------------------------------------------------------------

Readonly::Scalar my $DESC => q{Regular expression without "/x" flag - but not for split};
Readonly::Scalar my $EXPL => [ 236 ];

#-----------------------------------------------------------------------------

sub supported_parameters {
    return (
        {
            name               => 'minimum_regex_length_to_complain_about',
            description        =>
                q<The number of characters that a regular expression must contain before this policy will complain.>,
            behavior           => 'integer',
            default_string     => '0',
            integer_minimum    => 0,
        },
    );
}

sub default_severity     { return $SEVERITY_MEDIUM }
sub default_themes       { return qw<reneeb> }
sub applies_to           {
    return qw<
        PPI::Token::Regexp::Match
        PPI::Token::Regexp::Substitute
        PPI::Token::QuoteLike::Regexp
    >;
}

#-----------------------------------------------------------------------------

sub violates {
    my ( $self, $elem, $doc ) = @_;

    my $match = $elem->get_match_string();

    return if $self->{_minimum_regex_length_to_complain_about} >= length $match;
    return if _is_used_to_split( $elem );

    my $re = $doc->ppix_regexp_from_element( $elem );
    $re->modifier_asserted( 'x' )
        or return $self->violation( $DESC, $EXPL, $elem );

    return; # ok!;
}

sub _is_used_to_split {
    my ($elem) = @_;

    my $is_to_split = _elem_has_split_as_sibling( $elem );

    if ( !$is_to_split && $elem->parent->isa( 'PPI::Statement::Expression' ) ) {
        my $grandparent = $elem->parent->parent;
        $is_to_split    = _elem_has_split_as_sibling( $grandparent );
    }

    return $is_to_split;
}

sub _elem_has_split_as_sibling {
    my ($elem) = @_;

    my $has_sibling;
    while ( my $sib = $elem->sprevious_sibling ) {
        if ( "$sib" eq 'split' ) {
            $has_sibling = 1;
            last;
        }

        $elem = $sib;
    }

    return $has_sibling;
}

1;

__END__

#-----------------------------------------------------------------------------

=pod

=head1 DESCRIPTION

Extended regular expression formatting allows you mix whitespace and
comments into the pattern, thus making them much more readable.

    # Match a single-quoted string efficiently...

    m{'[^\\']*(?:\\.[^\\']*)*'};  #Huh?

    # Same thing with extended format...

    m{
        '           # an opening single quote
        [^\\']      # any non-special chars (i.e. not backslash or single quote)
        (?:         # then all of...
            \\ .    #    any explicitly backslashed char
            [^\\']* #    followed by an non-special chars
        )*          # ...repeated zero or more times
        '           # a closing single quote
    }x;


=head1 CONFIGURATION

You might find that putting a C</x> on short regular expressions to be
excessive.  An exception can be made for them by setting
C<minimum_regex_length_to_complain_about> to the minimum match length
you'll allow without a C</x>.  The length only counts the regular
expression, not the braces or operators.

    [RegularExpressions::RequireExtendedFormatting]
    minimum_regex_length_to_complain_about = 5

    $num =~ m<(\d+)>;              # ok, only 5 characters
    $num =~ m<\d\.(\d+)>;          # not ok, 9 characters

This option defaults to 0.

Because using C</x> on a regex which has whitespace in it can make it
harder to read (you have to escape all that innocent whitespace), by
default, you can have a regular expression that only contains
whitespace and word characters without the modifier.  If you want to
restrict this, turn on the C<strict> option.

    [RegularExpressions::RequireExtendedFormattingExceptForSplit]
    strict = 1

    $string =~ m/Basset hounds got long ears/;  # no longer ok

This option defaults to false.

=head1 METHODS

=head2 supported_parameters

Currently only one parameter is supported: C<minimum_regex_length_to_complain_about>.

Regular expressions that are shorter than this number, no violation is thrown.

=head2 default_theme

Default theme is C<reneeb>.

=head2 default_severity

Be default this policy is of medium severity.

=head2 applies_to

By default this policy applies to

=over

=item * PPI::Token::Regexp::Match

=item * PPI::Token::Regexp::Substitute

=item * PPI::Token::QuoteLike::Regexp

=back

=head1 NOTES

For common regular expressions like e-mail addresses, phone numbers,
dates, etc., have a look at the L<Regexp::Common|Regexp::Common> module.
Also, be cautions about slapping modifier flags onto existing regular
expressions, as they can drastically alter their meaning.  See
L<http://www.perlmonks.org/?node_id=484238> for an interesting
discussion on the effects of blindly modifying regular expression
flags.

=head1 TO DO

Add an exemption for regular expressions that contain C<\Q> at the
beginning and don't use C<\E> until the very end, if at all.

=for Pod::Coverage supported_parameters

=cut

