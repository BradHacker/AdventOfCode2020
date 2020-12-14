<?php
  $inputFile = fopen("input.txt", "r") or die("can't open input file...");
  $input = fread($inputFile, filesize("input.txt"));
  $lines = explode("\n", $input);
  $currMask = [];
  $mem = [];
  print "Initializing memory...\n";
  for ($i=0; $i < count($lines); $i++) { 
    $parts = explode(" = ", $lines[$i]);
    if ($parts[0] == "mask") {
      $currMask = $parts[1];
    } else {
      $halfParsed = substr($parts[0], 4);
      $address = substr($halfParsed, 0, strlen($halfParsed) - 1);
      $value = str_pad(decbin($parts[1]), 36, "0", STR_PAD_LEFT);
      for ($j = 0; $j < strlen($value); $j++) {
        if ($currMask[$j] != "X") {
          $value[$j] = $currMask[$j];
        }
      }
      $mem[$address] = bindec($value);
    }
  }
  print "Summing values in memory...\n";
  $sum = 0;
  foreach ($mem as $value) {
    $sum += $value;
  }
  print "Sum = " . number_format($sum, 0, ".", "") . "\n";
  fclose($inputFile);
?>