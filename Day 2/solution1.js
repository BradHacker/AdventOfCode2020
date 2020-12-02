const fs = require('fs');
const input = fs.readFileSync('./input.txt', { encoding: 'utf8' });
const inputLines = input.split('\n');

let validPassCount = 0;

inputLines.forEach(line => {
  let parts = line.split(' ');
  let bounds = parts[0].split('-');
  let lower = parseInt(bounds[0]);
  let upper = parseInt(bounds[1]);
  let charToRepeat = parts[1].charAt(0);
  let password = parts[2];

  let repeatCharCount = 0;
  password.split('').forEach(char => {
    if (char === charToRepeat) repeatCharCount++;
  })

  if (repeatCharCount >= lower && repeatCharCount <= upper) validPassCount++;
})

console.log(`${validPassCount} of ${inputLines.length} passwords were valid`);