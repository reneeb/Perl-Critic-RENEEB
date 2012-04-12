package Perl::Critic::RENEEB;

use warnings;
use strict;

# ABSTRACT: A collection of handy Perl::Critic policies

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

Perl::Critic::RENEEB is a collection of Perl::Critic policies that
is used in my programming environment

=head1 DESCRIPTION

The rules included with the Perl::Critic::RENEEB group include:

=head2 L<Perl::Critic::Policy::RegularExpressions::RequireExtendedFormattingExceptForSplit>

I use split with regular expressions regularly, but I don't want to use the x-modifier there. So
I wrote this policy to check all regular expressions in my programs but those used as a parameter to split.

=head1 AUTHOR

Renee Baecker, C<< <module@renee-baecker.de> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-perl-critic-otrs at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Perl-Critic-RENEEB>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Perl::Critic::RENEEB

You can also look for information at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Perl-Critic-RENEEB>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Perl-Critic-RENEEB>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Perl-Critic-RENEEB>

=item * Search CPAN

L<http://search.cpan.org/dist/Perl-Critic-RENEEB>

=item * Source code repository

L<http://github.com/reneeb/Perl-Critic-RENEEB>

=back

=head1 COPYRIGHT & LICENSE

Copyright 2012 Renee Baecker.

This program is free software; you can redistribute it and/or modify
it under the terms of:

=over 4

=item * the Artistic License version 2.0.

=back

=cut

1; # End of Perl::Critic::RENEEB
