#!/usr/bin/perl

use warnings;
use strict;
use AnyEvent::Twitter::Stream;

my $done = AnyEvent->condvar;

my($user, $password, $method, $args) = @ARGV;

my %args;
if ($method eq 'follow') {
    $args{follow} = $args;
    $method = 'filter';
} elsif ($method eq 'track') {
    $args{track}  = $args;
    $method = 'filter';
}

binmode STDOUT, ":utf8";

my $streamer = AnyEvent::Twitter::Stream->new(
    username => $user,
    password => $password,
    method   => $method || "sample",
    %args,
    on_tweet => sub {
        my $tweet = shift;
        print "$tweet->{user}{screen_name}: $tweet->{text}\n";
    },
    on_error => sub {
        my $error = shift;
        warn "ERROR: $error";
        $done->send;
    },
    on_eof   => sub {
        $done->send;
    },
);

# uncomment to test undef $streamer
# my $t = AE::timer 1, 0, sub { undef $streamer };

$done->recv;
