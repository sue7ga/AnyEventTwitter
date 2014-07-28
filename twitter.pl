use strict;
use warnings;

use Config::Pit;
use Data::Dumper;
use AnyEvent::Twitter;
use AnyEvent::Twitter::Stream;

my $auth = pit_get("example.com");
my $cv = AnyEvent->condvar;

my $twitter = AnyEvent::Twitter->new(%$auth);

my @list = qw/hogenion moznion suenion perlbeginners/;

$twitter->post('statuses/update',{
  status => 'm9(^^)',
},sub {
  my($header,$tweet) = @_;
  $cv->send;
});

$cv->recv;





