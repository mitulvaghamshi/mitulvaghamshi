import warier.Elf
import warier.Fighter
import warier.Hobbit
import warier.Human
import warier.Wizard

/**
 * Test all classes working correctly or not.
 */
class FakeWorldTest {
    private lateinit var hobbit1: Hobbit
    private lateinit var hobbit2: Hobbit
    private lateinit var elf1: Elf
    private lateinit var elf2: Elf
    private lateinit var human1: Human
    private lateinit var human2: Human
    private lateinit var fighter1: Fighter
    private lateinit var fighter2: Fighter
    private lateinit var wizard1: Wizard
    private lateinit var wizard2: Wizard

    @org.junit.jupiter.api.BeforeEach
    fun setUp() {
        println("Initializing Test Warier...")

        hobbit1 = Hobbit("Frodo")
        hobbit2 = Hobbit("Samwise", 8, 12, 2, 14, 10, 30)

        elf1 = Elf("Legolas")
        elf2 = Elf("Elrond", 14, 20, 18, 12, 1000, 80, "Forest", hobbit1)

        human1 = Human("Aragorn")
        human2 = Human("Wormtongue", 100, 12, 2, 16, 100, 50, elf2)

        fighter1 = Fighter("Boromir")
        fighter2 = Fighter("Faramir", 18, 15, 3, 8, 150, 55, elf1)

        wizard1 = Wizard("Gandalf")
        wizard2 = Wizard("Saruman", 8, 12, 4, 15, 2500, 90, elf1, 20)

        println("\nTwo Hobbits arrived:")
        println(hobbit1)
        println(hobbit2)

        println("\nTwo Elves arrived:")
        println(elf1)
        println(elf2)

        println("\nTwo Humans arrived:")
        println(human1)
        println(human2)

        println("\nTwo Fighters arrived:")
        println(fighter1)
        println(fighter2)

        println("\nTwo Wizards arrived:")
        println(wizard1)
        println(wizard2)
    }

    @org.junit.jupiter.api.AfterEach
    fun tearDown() = println("Test War Completed...")

    @org.junit.jupiter.api.Test
    fun test() {
        println("Starting Test War...")

        System.out.printf("\n%s attacks %s! \n", elf2.name, human2.name)
        elf2.attack(human2)
        println(human2)

        System.out.printf("\n%s steals from %s!\n", hobbit1.name, human2.name)
        hobbit1.stealFrom(human2)
        println(hobbit1)
        println(human2)

        System.out.printf("\n%s changes his best friend!\n", elf2.name)
        elf2.becomeFriendOf(hobbit2)
        println(elf2)

        System.out.printf("\n%s attacks %s!\n", fighter1.name, hobbit1.name)
        fighter1.attack(hobbit1)
        println(hobbit1)

        System.out.printf("\n%s heals %s!\n", wizard1.name, hobbit1.name)
        wizard1.heal(hobbit1)
        println(wizard1)
        println(hobbit1)

        System.out.printf("\n%s attacks itself!\n", fighter1.name)
        println(fighter1)
        fighter1.attack(fighter1)
        println(fighter1)
    }
}
