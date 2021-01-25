package adventOfCode2019.rocketFuel

import org.junit.jupiter.api.Assertions
import org.junit.jupiter.params.ParameterizedTest
import org.junit.jupiter.params.converter.ConvertWith
import org.junit.jupiter.params.provider.CsvSource

class RequiredFuelDoubleCheckTest {

    @ParameterizedTest()
    @CsvSource(
        "0, 0",
        "3, 0",
        "9, 1",
        "10, 1",
        "12, 2",
        "14, 2",
        "1969, 966",
        "100756, 50346"
    )
    fun `the fuel required for a single mass is the min required plus the fuel required for the mass of the fuel`(
        @ConvertWith(MassArg::class) givenMass: Mass,
        @ConvertWith(FuelArg::class) expectedFuel: Fuel
    ) {
        Assertions.assertEquals(
            expectedFuel,
            RocketFuelEstimate().doubleChecked(givenMass)
        )
    }

    @ParameterizedTest()
    @CsvSource(
        "[]; 0",
        "[9]; 1",
        "[8, 9]; 1",
        "[33, 33, 33, 33, 33]; 50",
        "[0, 3, 8, 9, 10, 12, 14, 1969, 100756]; 51318",
        delimiter = ';'
    )
    fun `the minimum fuel required for a multiple mass is the sum of double-checked fuel estimates of the single masses`(
        @ConvertWith(IntArrayArg::class) givenMasses: Array<Int>,
        @ConvertWith(FuelArg::class) expectedFuel: Fuel
    ) {
        Assertions.assertEquals(
            expectedFuel,
            RocketFuelEstimate().doubleChecked(givenMasses.map { Mass(it) })
        )
    }
}

fun RocketFuelEstimate.doubleChecked(vararg masses: Mass) = doubleChecked(masses.asSequence())
fun RocketFuelEstimate.doubleChecked(masses: List<Mass>) = doubleChecked(masses.asSequence())