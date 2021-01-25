package adventOfCode2019.rocketFuel

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.params.ParameterizedTest
import org.junit.jupiter.params.converter.ConvertWith
import org.junit.jupiter.params.provider.CsvSource

class FuelEstimateTest {

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
    fun `the estimated fuel required for a single mass is mass divided by tree, round down, and subtract 2`(
        @ConvertWith(MassArg::class) givenMass: Mass,
        @ConvertWith(FuelArg::class) expectedFuel: Fuel
    ) {
        assertEquals(
            expectedFuel,
            Fuel.estimateFor(givenMass)
        )
    }
}
