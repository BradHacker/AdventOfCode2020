//
//  Adevnt of Code 2020 - Day 13 Sol 2
//
//  main.swift
//  day_13
//
//  Created by Bradley on 12/13/20.
//

import Foundation

func mod(_ a: Int64, _ n: Int64) -> Int64 {
    precondition(n > 0, "modulus must be positive")
    let r = a % n
    return r >= 0 ? r : r + n
}

func extendedEuclid(a: Int64, b: Int64) -> (Int64, Int64) {
    if b == 0 {
        return (1, 0)
    }
//    print((a, b, a % b))
    let (x, y) = extendedEuclid(a: b, b: mod(a, b))
    let k: Int64 = a / b
//    print((x, y, k))
    return (y, x - (y * k))
}

func invertModulo(a: Int64, n: Int64) -> Int64 {
    var (b, _) = extendedEuclid(a: a, b: n)
    if b < 0 {
        b = mod((mod(b, n) + n), n)
    }
    return b
}

//print(extendedEuclid(a: Int64(609), b: Int64(17)))

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

let timeCanLeave = Int64(lines[0]) ?? 0
let buses = lines[1].split(separator: ",").map { Int64($0) ?? -1 }
//let buses = [Int64(67),Int64(7),Int64(59),Int64(61)]

let tempBuses = [17, 0, 13, 19]
let tempRems = [0, 1, 2, 3]

var N: Int = 1
for tempBus in tempBuses {
    if tempBus == 0 {
        continue
    }
    N *= tempBus
}

var NIs: [Int] = [Int](repeating: 0, count: tempBuses.count)
for i in 0...(tempBuses.count - 1) {
    if tempBuses[i] == 0 {
        continue
    }
    NIs[i] = N / tempBuses[i]
}

var UIs: [Int] = [Int](repeating: 0, count: tempBuses.count)
for i in 0...(tempBuses.count - 1) {
    print(String(NIs[i]) + "u" + String(i) + " === 1 (mod " + String(tempBuses[i]) + ")")
//    print(extendedEuclid(a: Int64(NIs[i]), b: Int64(tempBuses[i])))
    UIs[i] = Int(invertModulo(a: Int64(NIs[i]), n: Int64(tempBuses[i])))
}

var x: Int = 0
for i in 0...(tempBuses.count - 1) {
    print(String(tempBuses[i]) + " | " + String(i) + " | " + String(N) + "/" + String(tempBuses[i]) + " = " + String(NIs[i]) + " | " + String(NIs[i]) + "ui = 1 (mod " + String(tempBuses[i]) + ") => ui = " + String(UIs[i]))
    x += tempRems[i] * NIs[i] * UIs[i]
}

print(x)

for i in 0...(tempBuses.count - 1) {
    if tempBuses[i] == 0 {
        continue
    }
    print(x % tempBuses[i])
}


//var N: Int64 = 1
//for i in 0...(buses.count - 1) {
//    if buses[i] == -1 {
//        continue
//    }
//    N *= buses[i]
//}
//
//var NIs: [Int64] = [Int64](repeating: 0, count: buses.count)
//for i in 0...(buses.count - 1) {
//    if buses[i] == -1 {
//        continue
//    }
//    NIs[i] = N / buses[i]
//}
//
////print(NIs)
//
//var UIs: [Int64] = [Int64](repeating: 0, count: buses.count)
//for i in 0...(buses.count - 1) {
//    if buses[i] == -1 {
//        continue
//    }
//    UIs[i] = invertModulo(a: NIs[i], n: buses[i])
//}
//
////print(UIs)
//
//var x: Int64 = 0
//for i in 0...(buses.count - 1) {
//    if buses[i] == -1 {
//        continue
//    }
////    let col4: String =
//    print(String(buses[i]) + " | " + String(i) + " | " + String(N) + "/" + String(buses[i]) + " = " + String(NIs[i]) + " | " + String(NIs[i]) + "ui = 1 (mod " + String(buses[i]) + ") => ui = " + String(UIs[i]))
//    let product = Int64(i) * NIs[i] * UIs[i]
////    print(String(i) + " * " + String(NIs[i]) + " * " + String(UIs[i]) + " = " + String(product))
//    x += product
//}
//
//print(x)
//
//for i in 0...(buses.count - 1) {
//    if buses[i] == -1 {
//        continue
//    }
//    print((x % N) % buses[i])
//}


