object Greeting {

    fun sayHello(name: String = "Git") = "Hello, $name!"
}

fun main() {
    println(Greeting.sayHello())
}