# NAME

MojoX::Date::Local - Mojo::Date, but in my timezone

# SYNOPSIS

    use MojoX::Date::Local;

    say MojoX::Date::Local->new;             # => Wed, 27 May 2020 17:39:43 PDT
    say MojoX::Date::Local->new->to_datetime # => 2020-05-27T17:39:43-07:00

# DESCRIPTION

This module lets you use [Mojo::Date](https://metacpan.org/pod/Mojo%3A%3ADate)'s concise date / time functionality within the context of your own time zone.
That's mainly useful when logging to the console with a custom [Mojo::Log](https://metacpan.org/pod/Mojo%3A%3ALog) format:

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

# METHODS

A MojoX::Date::Local provides the same methods as [Mojo::Date](https://metacpan.org/pod/Mojo%3A%3ADate), overriding two for its own purposes.

## to\_datetime

Render local date+time in [RFC 3339](http://tools.ietf.org/html/rfc3339) format, with timezone offset.

## to\_string

Render local date+time in [RFC7231](https://tools.ietf.org/html/rfc7231#section-7.1.1.1) format.

# SEE ALSO

[Mojolicious](https://metacpan.org/pod/Mojolicious), [Mojo::Date](https://metacpan.org/pod/Mojo%3A%3ADate), [POSIX](https://metacpan.org/pod/POSIX)

# LICENSE

Copyright (C) Brian Wisti.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Brian Wisti <brianwisti@pobox.com>
