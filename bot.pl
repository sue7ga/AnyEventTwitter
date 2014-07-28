use strict;
use warnings;

use Config::Pit;
use Data::Dumper;
use AnyEvent::Twitter;
use AnyEvent::Twitter::Stream;

my @list = qw/suenion hogenion moznion/;

my $auth = pit_get("example.com");
my $cv = AnyEvent->condvar;

my $twitter = AnyEvent::Twitter->new(%$auth);

my $timer = AnyEvent->timer(
   after => 0,
   interval => 30,
   cb => sub{
     my $saying = shift @list;
     $cv->send unless $saying;

      $twitter->post('statuses/update',{
        status => $saying,
      },sub {
        my($header,$tweet) = @_;
        warn $header->{Reason};
        warn $tweet->{id_str} if $twitter;
      });
   }
);

$cv->recv;
