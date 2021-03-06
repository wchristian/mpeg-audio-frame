#!/usr/bin/perl -w

use strict;

use Test::More tests => 5;

BEGIN {
	if ($] >= 5.006){
		require Fcntl; Fcntl->import(qw/SEEK_SET/);
	} else {
		require POSIX; POSIX->import(qw/SEEK_SET/);
	}
}

BEGIN { use_ok("MPEG::Audio::Frame") }

isa_ok(my $read = MPEG::Audio::Frame->read(\*DATA), "MPEG::Audio::Frame", "regular read");

seek DATA, 0, SEEK_SET;

tie *FH, 'MPEG::Audio::Frame', *DATA;

isa_ok(my $tie = <FH>, "MPEG::Audio::Frame", "tie");

is("$tie", "$read", "string eq");
is_deeply($tie->{header}, $read->{header}, "tie produces the same thing as explicitly reading");


__DATA__
���@     7�     �      �      �                                                                                                                                                                                                                                                                                                                                                                                                 

