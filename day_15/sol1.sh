#!/bin/bash

if [ $# -eq 0 ]; then
  echo "USAGE: ./sol1.sh [start_numbers]"
  exit
fi

input="$1"
IFS=',' read -r -a array <<< "$input"

saidNums=()
totalNums=0
# Starting num iteration
for num in "${array[@]}"; do
  saidNums+=( $num )
  let totalNums++
done

echo "Loaded $totalNums starting nums"

foundIndex=-1

function containsElement {
  # shift
  #i in "${!foo[@]}"
  # echo "finding $1"
  # let "i = $2 - 2"
  for ((i=${#saidNums[@]}-2; i>=0; i--)); do
    # echo "Index $i"
    if [[ "${saidNums[$i]}" == "${1}" ]]; then
      foundIndex=$i
      return
    fi
  done
  foundIndex=-1
}

echo "Generating numbers"

until [ $totalNums -eq 2020 ]; do
  containsElement ${saidNums[*]: -1} $totalNums
  # echo "Num pos: $foundIndex"
  # echo "Num pos: ${saidNums[5]}"
  if [[ $foundIndex -ne -1 ]]; then
    # echo "num said before at $foundIndex"
    let "diff = $totalNums - ($foundIndex + 1)"
    # echo "$totalNums - $foundIndex = $diff"
    saidNums+=($diff)
  else
    # echo "0"
    saidNums+=(0)
  fi
  let totalNums++
done

echo "The ${totalNums}th number said was ${saidNums[*]: -1}"