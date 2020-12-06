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
my $group_size = 0;

my $sum = 0;

sub sum_group {
  for(keys %questions) {
      if ($questions{$_} == $group_size) {
        $sum += 1;
      }
    }
    %questions = ();
    $group_size = 0;
}

while( my $line = $file_handle->getline() ) {
  if ($line eq "\n") {
    sum_group();
  } else {
    $group_size += 1;
    my @chars = split('', $line);
    my $c;
    for $c (@chars) {
      if ($c ne "\n") {
        if (exists $questions{$c}) {
          $questions{$c} += 1;
        } else {
          $questions{$c} = 1;
        }
      }
    }
  }
  # print($line);
}

sum_group();

print("\n\nSum of agrred upon questions is $sum\n");