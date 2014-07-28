use strict;
use warnings;
use Config::Pit;

use Data::Dumper;

use AnyEvent::Twitter;
use AnyEvent::Twitter::Stream;

my $auth = Config::Pit::get('example.com');

my $cv = AnyEvent->condvar;

my $twitter = AnyEvent::Twitter->new(%$auth);

my $stream = AnyEvent::Twitter::Stream->new(
  %$auth,
  method => 'filter',
  track  => '@sue7ga',
  on_tweet => sub{
    my $tweet = shift;
    print "$tweet->{user}{screen_name}:$tweet->{text}","\n";
  },
);

$cv->recv;
