# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 1.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 9 };
use Number::Phone::Country;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

my_test("219-464-4824","US");
my_test("1-800-000-0000","US");
my_test("1 800-000-0000","US");
my_test("(270) 274-5431","US");
my_test("51-1-2217244","PE");
my_test("351-21-8463452","PT");
my_test("1 416 595 6136","CA");
my_test("787-764-1185","PR");

sub my_test {
  my ($phone, $expected_country) = @_;
  my $actual_country = phone2country($phone);
  ok($actual_country,$expected_country);
}
