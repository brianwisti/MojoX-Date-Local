package MojoX::Date::Local;
use Mojo::Date -base;

our $VERSION = "0.02";

use POSIX qw(strftime);

sub to_datetime {

  # RFC 3339 (1994-11-06T00:49:37-08:00)
  my $epoch = shift->epoch;
  my @time  = localtime $epoch;
  my $fmt
    = $epoch =~ m{ (\.\d+) $ }x
    ? '%Y-%m-%dT%H:%M:%S' . $1 . '%z'
    : '%Y-%m-%dT%H:%M:%S%z';
  my $timestamp = strftime $fmt, @time;

  # %z is '+HHMM', but RFC-3339 wants '+HH:MM'
  $timestamp =~ s{ (\d\d)(\d\d) $}{$1:$2}x;
  return $timestamp;
}

# sub to_string { # Sun, 06 Nov 1994 00:49:37 PST }
sub to_string {

  # RFC 7231 (Sun, 06 Nov 1994 08:49:37 GMT)
  my $epoch = shift->epoch;
  my @time  = localtime $epoch;
  my $fmt
    = $epoch =~ m{ (\.\d+) $ }x
    ? '%a, %d %b %Y %H:%M:%S' . $1 . ' %Z'
    : '%a, %d %b %Y %H:%M:%S %Z';
  my $timestamp = strftime $fmt, @time;
  return $timestamp;
}

1;
__END__

=encoding utf-8

=head1 NAME

MojoX::Date::Local - Mojo::Date, but in my timezone

=head1 SYNOPSIS

  use MojoX::Date::Local;

  say MojoX::Date::Local->new;             # => Wed, 27 May 2020 17:39:43 PDT
  say MojoX::Date::Local->new->to_datetime # => 2020-05-27T17:39:43-07:00

=head1 DESCRIPTION

This module lets you use L<Mojo::Date>'s concise date / time functionality within the context of your own time zone.
That's mainly useful when logging to the console with a custom L<Mojo::Log> format:

  use Mojo::Log;
  use MojoX::Date::Local;

  my $logger = Mojo::Log->new;

  $logger->format(
    sub ($time, $level, @lines) {
      my ($time, $level, @lines) = @_;
      my $timestamp = MojoX::Date::Local->new($time)->to_datetime;
      my $prefix    = "[$timestamp] [$level]";
      my $message   = join "\n", @lines, "";
      return "$prefix $message";
    }
  );



=head1 METHODS

A MojoX::Date::Local provides the same methods as L<Mojo::Date>, overriding two for its own purposes.

=head2 to_datetime

Render local date+time in L<RFC 3339|http://tools.ietf.org/html/rfc3339> format, with timezone offset.

=head2 to_string

Render local date+time in L<RFC7231|https://tools.ietf.org/html/rfc7231#section-7.1.1.1> format.

=head1 SEE ALSO

L<Mojolicious>, L<Mojo::Date>, L<POSIX>

=head1 LICENSE

Copyright (C) Brian Wisti.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Brian Wisti E<lt>brianwisti@pobox.comE<gt>

=cut
