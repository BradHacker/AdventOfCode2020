const fs = require('fs');
const input = fs.readFileSync('./input.txt', { encoding: 'utf8' });
const inputLines = input.split('\n');

let validPassCount = 0;

inputLines.forEach(line => {
  let parts = line.split(' ');
  let positions = parts[0].split('-');
  let pos1 = parseInt(positions[0]);
  let pos2 = parseInt(positions[1]);
  let charToCheck = parts[1].charAt(0);
  let password = parts[2];

  let pos1Check = password.charAt(pos1 - 1) === charToCheck;
  let pos2Check = password.charAt(pos2 - 1) === charToCheck;

  if ((pos1Check && !pos2Check) || (!pos1Check && pos2Check)) validPassCount++;
})

console.log(`${validPassCount} of ${inputLines.length} passwords were valid`);