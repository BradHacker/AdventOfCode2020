package sol1

import java.io.File

fun main(args: Array<String>) {
    val lines = readLines("data/input.txt")
    val adaptors = lines.map { Integer.parseInt(it) }
    val sortedAdaptors = adaptors.sorted()
    println(sortedAdaptors)
    var oneDiffs = 0
    var threeDiffs = 1
    if (sortedAdaptors[0] == 1)
        oneDiffs++
    else if (sortedAdaptors[0] == 3)
        threeDiffs++
    for (i in 0..(sortedAdaptors.size - 2)) {
//        print("" + sorted_adaptors[i] + " ")
        if (sortedAdaptors[i + 1] - sortedAdaptors[i] == 1)
            oneDiffs++
        else if (sortedAdaptors[i + 1] - sortedAdaptors[i] == 3)
            threeDiffs++
    }
    println("One Diffs: $oneDiffs");
    println("Three Diffs: $threeDiffs");
    println("Product: " + (oneDiffs * threeDiffs));
}

fun readLines(fileName: String): List<String>
    = File(fileName).useLines { it.toList() }
