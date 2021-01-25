package adventOfCode2019.rocketFuel

data class Mass(val inKg: Double) {

    constructor(inKg: Int) : this(inKg.toDouble())
}
