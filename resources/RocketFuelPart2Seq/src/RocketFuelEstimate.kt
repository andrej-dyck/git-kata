package adventOfCode2019.rocketFuel

class RocketFuelEstimate {

    fun minRequired(masses: Sequence<Mass>): Fuel =
        fuelEstimates(masses).sum()

    private fun fuelEstimates(masses: Sequence<Mass>) =
        masses.map(Fuel::estimateFor).filter { it.hasMass() }

    fun doubleChecked(masses: Sequence<Mass>): Fuel =
        fuelEstimatesWithFuelMass(masses).sum()

    private fun fuelEstimatesWithFuelMass(masses: Sequence<Mass>) =
        generateSequence(fuelEstimates(masses)) { fuelEstimates(it.toMasses()) }
            .takeWhile { it.any() }
            .flatten()
}

private fun Sequence<Fuel>.toMasses() = map { it.mass() }

fun RocketFuelEstimate.minRequired(vararg masses: Mass) = minRequired(masses.asSequence())