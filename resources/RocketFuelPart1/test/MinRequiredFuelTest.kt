package adventOfCode2019.rocketFuel

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.params.ParameterizedTest
import org.junit.jupiter.params.converter.ConvertWith
import org.junit.jupiter.params.provider.CsvSource

class MinRequiredFuelTest {

    @ParameterizedTest()
    @CsvSource(
        "0, 0",
        "3, 0",
        "8, 0",
        "9, 1",
        "10, 1",
        "12, 2",
        "14, 2",
        "1969, 654",
        "100756, 33583"
    )
    fun `the minimum fuel required for a single mass is mass divided by tree, round down, and subtract 2`(
        @ConvertWith(MassArg::class) givenMass: Mass,
        @ConvertWith(FuelArg::class) expectedFuel: Fuel
    ) {
        assertEquals(
            expectedFuel,
            RocketFuelEstimate().minRequired(givenMass)
        )
    }

    @ParameterizedTest()
    @CsvSource(
        "[]; 0",
        "[9]; 1",
        "[8, 9]; 1",
        "[33, 33, 33, 33, 33]; 45",
        "[0, 3, 8, 9, 10, 12, 14, 1969, 100756]; 34243",
        delimiter = ';'
    )
    fun `the minimum fuel required for a multiple mass is the sum of fuel estimates of the single masses`(
        @ConvertWith(IntArrayArg::class) givenMasses: Array<Int>,
        @ConvertWith(FuelArg::class) expectedFuel: Fuel
    ) {
        assertEquals(
            expectedFuel,
            RocketFuelEstimate().minRequired(givenMasses.map { Mass(it) })
        )
    }
}

fun RocketFuelEstimate.minRequired(vararg masses: Mass) = minRequired(masses.asSequence())
fun RocketFuelEstimate.minRequired(masses: List<Mass>) = minRequired(masses.asSequence())