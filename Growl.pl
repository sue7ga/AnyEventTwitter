use strict;
use warnings;
use utf8;

use Growl::Any;

my $growl = Growl::Any->new;

use AnyEvent;
use AnyEvent::Twitter;
use AnyEvent::Twitter::Stream;
use Data::Dumper;

my $cv = AE::cv;

my $method = 'filter';
my $name   = 'sue7ga';

my $consumer_key    = "m4S2D4J8wqVgiqUhzyONuJc0r";
my $consumer_secret = "UC09JIayBBxWa5yE3OOAWYOIrnIiYeaLRqSIS3kg6jAeMIrEag";
my $token = "2605721107-HVkOvzY3QjnJbc12vYkHtZbzd97SoZ1tZuLcoZZ";
my $token_secret = "382cVOgudrczK4FhZZwAepWNQnoL4cmV1imma86KCTqFD";

my $stream = AnyEvent::Twitter::Stream->new(
  consumer_key  => $consumer_key,
  consumer_secret => $consumer_secret,
  token => $token,
  token_secret => $token_secret,
  method => $method,
  track => '@'.$name,
  on_tweet => sub{
     my $tweet = shift;
     print "hoge";
  },
  on_error => sub {
		my $message = shift;
		print "ERROR: $message\n";
		$cv->send;
  },
);

$cv->recv;

print Dumper $stream;





