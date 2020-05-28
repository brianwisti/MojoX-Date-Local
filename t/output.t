use Mojo::Base -strict;

use Test::More 1.302175;
use Mojo::Date;
use MojoX::Date::Local;

my $epoch             = 784111777;
my $micro_epoch       = "$epoch.123";
my $test_tz           = "America/Los_Angeles";
my $date_iso          = "1994-11-06T00:49:37-08:00";
my $date_micro_iso    = "1994-11-06T00:49:37.123-08:00";
my $date_string       = "Sun, 06 Nov 1994 00:49:37 PST";
my $date_micro_string = "Sun, 06 Nov 1994 00:49:37.123 PST";

$ENV{TZ} = $test_tz;

# Wed, 27 May 2020 10:29:49 -0700
chomp(my $date_http = `date --rfc-3339=seconds --date='\@$epoch'`);

my $local_date = MojoX::Date::Local->new($epoch);

is $local_date->to_datetime, $date_iso,
  "datetime should match RFC 3339 for system's current offset";

is "$local_date", $date_string,
  "stringified MojoX::Date::Local should include time zone info";

my $micro_date = MojoX::Date::Local->new($micro_epoch);
is $micro_date->to_datetime, $date_micro_iso,
  "datetime extends to sub-seconds if included in epoch";

is "$micro_date", $date_micro_string,
  "stringification extends to sub-seconds if included in epoch";

done_testing();
