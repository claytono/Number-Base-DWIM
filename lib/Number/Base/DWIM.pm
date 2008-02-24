package Number::Base::DWIM;

use strict;
use warnings;
use overload
  'fallback' => 1,
  '""' => \&stringify,
  '0+' => \&numify;

our $VERSION = 0.02;

=head1 NAME

Number::Base::DWIM - delay parsing of based constants as long as possible.

=head1 SYNOPSIS

use Numbers::Base::DWIM

my $x = 011;
print $x, "\n";  # prints 9
print "$x\n";    # prints 011

print oct($x)    # prints 011

=head1 DESCRIPTION

This module will delay parsing of based numeric constants (0b010101,
0655, 0xff) until the last possible moment.  This means that if you
use the constant as a string, then it will evaluate to the same form
that the constant was declared in.

This module was developed after an discussion where some people found
the behavior of C<perl -e 'print oct 011, "\n";'> to be confusing.
This module works around this by overloading the parsing of binary,
hexidecimal and octal numeric constants.  It then stores them as a
string internally, until either numification or stringification is
requested.

=head1 BUGS

Due to a bug in L<overload>, constants inside of and C<eval '...'>
won't be handled specially.

=head1 AUTHOR

Clayton OE<apos>Neill <CMO@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2006 by Clayton OE<apos>Neill

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

sub import {
  my $self = shift;
  overload::constant binary => sub { $self->new(shift) };
}

sub new {
  my $class = shift;
  my $num = shift;
  bless [ $num ], $class;
}

sub stringify {
  my $self = shift;
  $self->[0];
}

sub numify {
  my $self = shift;
  oct($self->[0]);
}

1;
