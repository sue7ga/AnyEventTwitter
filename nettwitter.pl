use strict;
use warnings;
use Encode;

use Net::Twitter;

my $consumer_key = "m4S2D4J8wqVgiqUhzyONuJc0r";
my $consumer_secret = "UC09JIayBBxWa5yE3OOAWYOIrnIiYeaLRqSIS3kg6jAeMIrEag";
my $token = "2605721107-HVkOvzY3QjnJbc12vYkHtZbzd97SoZ1tZuLcoZZ";
my $token_secret = "382cVOgudrczK4FhZZwAepWNQnoL4cmV1imma86KCTqFD";

my $nt = Net::Twitter->new(
  traits => ['API::RESTv1_1'],
  consumer_key => $consumer_key,
  consumer_secret => $consumer_secret,
  access_token => $token,
  access_token_secret => $token_secret,
  ssl => 1
);

use Data::Dumper;

my $query = "テスト";
my $sinceId = 0;

my $res = $nt->mentions();

foreach my $mention(@$res){
  my $mention_text = $mention->{text};
  my $screen_name = $mention->{user}->{screen_name};
  my $userid = $mention->{user}->{id};

  print Encode::encode_utf8($mention_text),"\n"; 
  print Encode::encode_utf8($screen_name),"\n"; 
  print $userid,"\n";

}



