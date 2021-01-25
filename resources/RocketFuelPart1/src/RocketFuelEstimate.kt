package adventOfCode2019.rocketFuel

class RocketFuelEstimate {

    fun minRequired(masses: Sequence<Mass>): Fuel =
        masses.map(Fuel::estimateFor).sum()
}