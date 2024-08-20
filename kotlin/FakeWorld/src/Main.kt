/**
 * Create instances of all the classes and tests the communication between them
 * by calling methods of each other and passing the messages
 * This program is highly dependent on the concept of Inheritance
 *
 * The [main] method which acts as an entry point of a program
 */
fun main() {
    println("\n*** Welcome to the town of Hogsface in the magical land of Foon ***\n")

    val world = FakeWorld()
    world.startWar()
}
