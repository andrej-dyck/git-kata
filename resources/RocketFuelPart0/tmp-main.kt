package adventOfCode2019.rocketFuel

fun main() {
    println("${Mass(1000.0)}")
    println("${Fuel(400.0)}")

    (0..42).forEach {
        val mass = Mass(it.toDouble())
        println("estimated fuel for $mass = ${Fuel.estimateFor(mass)}")
    }
}