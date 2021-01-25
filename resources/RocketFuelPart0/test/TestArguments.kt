package adventOfCode2019.rocketFuel

import org.junit.jupiter.params.converter.TypedArgumentConverter

class FuelArg : TypedArgumentConverter<String, Fuel>(String::class.java, Fuel::class.java) {

    override fun convert(source: String?) = Fuel(source?.toDouble() ?: 0.0)
}

class MassArg : TypedArgumentConverter<String, Mass>(String::class.java, Mass::class.java) {

    override fun convert(source: String?) = Mass(source?.toDouble() ?: 0.0)
}