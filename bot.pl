use strict;
use warnings;

use Config::Pit;
use Data::Dumper;
use AnyEvent::Twitter;
use AnyEvent::Twitter::Stream;
use XML::Feed;
use URI;
use utf8;

my $feed = XML::Feed->parse(URI->new('http://alfalfalfa.com/index.rdf')) or die XML::Feed->errstr;
my $feeds = [];
  for my $entry($feed->entries){
    push @$feeds,{title => $entry->{entry}->{title},link =>  $entry->{entry}->{link},subject => Encode::encode_utf8($entry->{entry}->{dc}->{subject}),date => $entry->{entry}->{dc}->{date},content => $entry->{entry}->{content}->{encoded}};
  }

my $auth = pit_get("example.com");
my $cv = AnyEvent->condvar;

my $twitter = AnyEvent::Twitter->new(%$auth);

my $timer = AnyEvent->timer(
   after => 0,
   interval => 60*60,
   cb => sub{
     my $saying = shift @$feeds;
     $cv->send unless $saying; 
      $twitter->post('statuses/update',{
        status => $saying->{title}."※アルファルファ→http://2chmatome.red/alfa",
      },sub {
        my($header,$tweet) = @_;
        warn $header->{Reason};
        warn $tweet->{id_str} if $twitter;
      });
   }
);

$cv->recv;
