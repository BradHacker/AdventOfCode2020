#!/usr/bin/perl
use strict;
use warnings;

use Path::Tiny;
use autodie;

my $dir = path("./");

my $file = $dir->child("input.txt");

my $content = $file->slurp_utf8();

my $file_handle = $file->openr_utf8();

my %questions = ();

my $sum = 0;

sub sum_group {
  $sum += keys %questions;
  %questions = ();
}

while( my $line = $file_handle->getline() ) {
  if ($line eq "\n") {
    sum_group();
  }
  my @chars = split('', $line);
  my $c;
  for $c (@chars) {
    if ($c ne "\n") {
      $questions{$c} = 'Y';
    }
  }
  # print($line);
}

sum_group();

print("\n\nSum of yesses is $sum\n");