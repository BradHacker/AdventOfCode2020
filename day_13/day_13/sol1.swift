//
//  main.swift
//  day_13
//
//  Created by Bradley on 12/13/20.
//

import Foundation

let inputFile = "input.txt"

let fileUrl = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("input.txt")
var contents: String = "";

do {
    contents = try String(contentsOf: fileUrl, encoding: .utf8)
}
catch {
    print("uhoh, something went wrong while reading the file...")
}

let lines = contents.split(separator: "\n")

let timeCanLeave = Int(lines[0]) ?? 0
print("You can only leave after " + String(timeCanLeave))
let buses = lines[1].split(separator: ",").map { Int($0) ?? 0 }
var earliestTimePerBus = [Int](repeating: 0, count: buses.endIndex)

for i in 0...(buses.endIndex - 1) {
    if buses[i] == 0 {
        continue
    }
    var sum = 0
    while (sum < timeCanLeave) {
        sum += buses[i]
    }
    earliestTimePerBus[i] = sum
    print("Checked bus #" + String(i) + " | " + String(sum))
}

var lowestTime = Int.max
var lowestID = 0

for i in 0...(buses.endIndex - 1) {
    if buses[i] == 0 {
        continue
    }
    if (earliestTimePerBus[i] < lowestTime) {
        lowestTime = earliestTimePerBus[i]
        lowestID = buses[i]
    }
}

print("First bus you can catch has the ID " + String(lowestID))
print("The time you'll need to wait is " + String(lowestTime))
print("Product: " + String(lowestID * (lowestTime - timeCanLeave)))
//for i in 0..timeCanLeave.length {
//
//}
