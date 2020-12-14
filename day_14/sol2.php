<?php
  function WriteToAddresses(Array &$memory, String $maskedAddress, int $value)
  {
    if (strpos($maskedAddress, "X") === false) {
      $memory[$maskedAddress] = $value;
    } else {
      $before = strstr($maskedAddress, "X", true);
      $after = strstr($maskedAddress, "X");
      $after = substr($after, 1);
      WriteToAddresses($memory, $before . "0" . $after, $value);
      WriteToAddresses($memory, $before . "1" . $after, $value);
    }
  }
  $inputFile = fopen("input.txt", "r") or die("can't open input file...");
  $input = fread($inputFile, filesize("input.txt"));
  $lines = explode("\n", $input);
  $currMask = "";
  $mem = [];
  print "Initializing memory...\n";
  for ($i=0; $i < count($lines); $i++) { 
    $parts = explode(" = ", $lines[$i]);
    if ($parts[0] == "mask") {
      $currMask = $parts[1];
    } else {
      $halfParsed = substr($parts[0], 4);
      $address = str_pad(decbin(substr($halfParsed, 0, strlen($halfParsed) - 1)), 36, "0", STR_PAD_LEFT);
      $value = $parts[1];
      for ($j = 0; $j < strlen($currMask); $j++) {
        if ($currMask[$j] != "0") {
          $address[$j] = $currMask[$j];
        }
      }
      WriteToAddresses($mem, $address, $value);
    }
  }
  print "Summing " . count($mem) . " values in memory...\n";
  $sum = 0;
  foreach ($mem as $val) {
    $sum += $val;
  }
  print "Sum = " . number_format($sum, 0, ".", "") . "\n";
  fclose($inputFile);
?>