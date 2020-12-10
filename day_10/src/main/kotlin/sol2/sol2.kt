package sol2

import java.io.File
import java.math.BigInteger

val memo: HashMap<Int, BigInteger> = HashMap()

fun main(args: Array<String>) {
    val lines = readLines("data/input.txt")
    val adaptors = lines.map { Integer.parseInt(it) }
    val sortedAdaptors = adaptors.sorted()
    val sortedAdaptorsList: ArrayList<Int> = ArrayList(sortedAdaptors)
    println("Permutations: " + computeNumArrangements(0, sortedAdaptorsList))
}

fun readLines(fileName: String): List<String> = File(fileName).useLines { it.toList() }

fun computeNumArrangements(currentAdapter: Int, adaptors: ArrayList<Int>): BigInteger {
    if (adaptors.size == 0)
        return (1).toBigInteger()
    var paths: BigInteger = (0).toBigInteger()
    for (i in 0 until adaptors.size) {
        if (adaptors[i] - currentAdapter <= 3) {
            if (!memo.containsKey(adaptors[i])) {
                val numPaths = computeNumArrangements(adaptors[i], ArrayList(adaptors.subList(i + 1, adaptors.size)))
                memo[adaptors[i]] = numPaths
            }
            paths += memo[adaptors[i]]!!
        }
    }
    return paths
}