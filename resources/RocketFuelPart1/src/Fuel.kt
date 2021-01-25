package adventOfCode2019.rocketFuel

import kotlin.math.floor

data class Fuel(val inKg: Double) {

    init {
        require(inKg >= 0)
    }

    companion object {
        fun estimateFor(mass: Mass) = Fuel(
            maxOf(floor(mass.inKg / 3.0) - 2, 0.0)
        )
    }
}

fun Sequence<Fuel>.sum() = Fuel(sumByDouble { it.inKg })