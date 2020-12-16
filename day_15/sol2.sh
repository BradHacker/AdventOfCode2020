#!/bin/bash

if [ $# -eq 0 ]; then
  echo "USAGE: ./sol1.sh [start_numbers]"
  exit
fi

input="$1"
IFS=',' read -r -a array <<< "$input"

declare -a values
turnNum=1
speaking=-1
nextNum=0
# Starting num iteration
for num in "${array[@]}"; do
  speaking=$num
  values[$speaking]=$turnNum
  let turnNum++
done

echo "Loaded ${#array[@]} starting nums"

function exists {
  if [ "$2" != in ]; then
    echo "Incorrect usage."
    echo "Correct usage: exists {key} in {array}"
    return
  fi
  eval '[ ${'$3'[$1]+muahaha} ]'
}

echo "Generating numbers..."

while [ $turnNum -lt 30000000 ]; do
  # echo -ne " | $turnNum\r"
  speaking=$nextNum
  if ! exists $speaking in values; then
    let "nextNum = 0"
  else
    let "nextNum = $turnNum - ${values[$speaking]}"
  fi
  values[$speaking]=$turnNum
  let turnNum++
done

echo "The ${turnNum}th number said was $nextNum"