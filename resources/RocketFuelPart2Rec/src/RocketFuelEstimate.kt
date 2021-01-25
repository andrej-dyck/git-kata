package adventOfCode2019.rocketFuel

class RocketFuelEstimate {

    fun minRequired(masses: Sequence<Mass>): Fuel =
        fuelEstimates(masses).sum()

    private fun fuelEstimates(masses: Sequence<Mass>) =
        masses.map(Fuel::estimateFor).filter { it.hasMass() }

    fun doubleChecked(masses: Sequence<Mass>): Fuel =
        takingFuelMassIntoAccount(fuelEstimates(masses)).sum()

    private tailrec fun takingFuelMassIntoAccount(
        estimates: Sequence<Fuel>,
        additionalMasses: Sequence<Mass> = estimates.toMasses()
    ): Sequence<Fuel> =
        if (additionalMasses.none()) estimates
        else {
            val additionalFuel = fuelEstimates(additionalMasses)
            takingFuelMassIntoAccount(estimates + additionalFuel, additionalFuel.toMasses())
        }
}

private fun Sequence<Fuel>.toMasses() = map { it.mass() }

fun RocketFuelEstimate.minRequired(vararg masses: Mass) = minRequired(masses.asSequence())