package Perl::Critic::RENEEB;

use warnings;
use strict;

# ABSTRACT: A collection of handy Perl::Critic policies

our $VERSION = '2.04';

=head1 SYNOPSIS

Perl::Critic::RENEEB is a collection of Perl::Critic policies that
is used in my programming environment

=head1 DESCRIPTION

The rules included with the Perl::Critic::RENEEB group include:

=head2 L<Perl::Critic::Policy::RegularExpressions::RequireExtendedFormattingExceptForSplit>

I use split with regular expressions regularly, but I don't want to use the x-modifier there. So
I wrote this policy to check all regular expressions in my programs but those used as a parameter to split.

=head2 L<Perl::Critic::Policy::Reneeb::ProhibitBlockEval>

Use C<try{...}> from L<Try::Tiny|https://metacpan.org/pod/Try::Tiny> instead of C<eval{...}>.

=head2 L<Perl::Critic::Policy::Reneeb::Capitalization>

Checks for capitalization of package names, subroutines, etc. It's a subclass of
L<Perl::Critic::Policy::NamingConventions::Capitalization>, but it adds the parameter
C<full_qualified_package_exemptions> to exclude packages by "full qualified namespace".

    full_qualified_package_exemptions = Test::Command::.*

excludes all packages in the C<Test::Command::> namespace from the check.

=cut

1; # End of Perl::Critic::RENEEB
