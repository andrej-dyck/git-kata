package adventOfCode2019.rocketFuel

import org.junit.jupiter.params.converter.TypedArgumentConverter

class IntArrayArg : TypedArgumentConverter<String, Array<Int>>(String::class.java, Array<Int>::class.java) {

    override fun convert(source: String?) = source?.toArray { toInt() } ?: emptyArray()
}

inline fun <reified T> String.toArray(parseElement: String.() -> T): Array<T> =
    if (matches("\\[\\s*]".toRegex())) emptyArray()
    else removeSurrounding("[", "]")
        .split(',')
        .map { it.trim() }
        .map(parseElement)
        .toTypedArray()

class FuelArg : TypedArgumentConverter<String, Fuel>(String::class.java, Fuel::class.java) {

    override fun convert(source: String?) = Fuel(source?.toDouble() ?: 0.0)
}

class MassArg : TypedArgumentConverter<String, Mass>(String::class.java, Mass::class.java) {

    override fun convert(source: String?) = Mass(source?.toDouble() ?: 0.0)
}