import utils.Warier
import utils.WarierType
import utils.WarierType.ANY_WARIER
import utils.WarierType.ELF
import utils.WarierType.FIGHTER
import utils.WarierType.HOBBIT
import utils.WarierType.HUMAN
import utils.WarierType.WIZARD
import warier.Elf
import warier.Fighter
import warier.Hobbit
import warier.Human
import warier.Humanoid
import warier.Wizard
import kotlin.system.exitProcess

class FakeWorld {
    private companion object {
        private const val GAME_MENU = """
----------------------
1. Create new warier
2. Start a fight
3. Steal money
4. Heal warier
5. Change friend
6. View warier List
7. Exit!
----------------------
Enter your choice: #
"""
        private const val WARIER_MANU = """
All warier - can attack and defend
--------------------------------------------
1. Hobbits - can steal money
2. Elves   - can have a patron or be a rival
3. Fighter - can double attack
4. Wizard  - can heal
5. Human   - easy life
--------------------------------------------
Select warier type: #
"""
    }

    private val warierList = mutableListOf<Humanoid>()

    fun startWar() {
        println(GAME_MENU)

        when (Integer.parseInt(readln())) {
            1 -> createWarier()
            2 -> createAttack()
            3 -> stealMoney()
            4 -> healWarier()
            5 -> changeFriend()
            6 -> display(warierList, true)
            7 -> quit()
            else -> println("[ERROR]: Invalid input: choose between (1-7).")
        }
        startWar()
    }

    /**
     * Create new warier.
     * by default all the warier allowed to attack and defend
     * and some of them are also have unique capabilities
     */
    private fun createWarier() {
        println(WARIER_MANU)
        buildWarier(WarierType.entries[Integer.parseInt(readln()) - 1])
        display(warierList, true)
    }

    /**
     * Create an attack between two warier.
     * Defender will lose health, while attacker doesn't gain anything.
     */
    private fun createAttack() {
        val attacker = chooseWarier(ANY_WARIER)
        val opponent = chooseWarier(ANY_WARIER)
        attacker.attack(opponent)
        println(opponent)
    }

    /**
     * Hobbits can steal money from others.
     * Warier will gain some coins, while other loses.
     */
    private fun stealMoney() {
        val hobbit = chooseWarier(HOBBIT) as Hobbit
        val other = chooseWarier(ANY_WARIER)
        hobbit.stealFrom(other)
        println(hobbit)
        println(other)
    }

    /**
     * Wizards are capable of healing other warier.
     * Dead warier can become alive by the healing.
     * Warier will gain some health, while Wizard lose some of healing power.
     */
    private fun healWarier() {
        val wizard = chooseWarier(WIZARD) as Wizard
        val other = chooseWarier(ANY_WARIER)
        wizard.heal(other)
        println(wizard)
        println(other)
    }

    /**
     * Elf can change its friend.
     * Elf only allowed to choose Hobbit as a friend.
     */
    private fun changeFriend() {
        val elf = chooseWarier(ELF) as Elf
        val hobbit = chooseWarier(HOBBIT) as Hobbit
        elf.becomeFriendOf(hobbit)
        println(elf)
    }


    /**
     * Choose a residence for Elf.
     */
    private fun chooseClan(): String {
        println("\nSelect clan: ")
        println("1. City")
        println("2. Forest")

        val preferCity = Integer.parseInt(readln()) == 1
        return Elf.getResidence(preferCity)
    }

    /**
     * Get healing power for Wizard.
     */
    private fun mGetMagicRating(): Int {
        print("Enter magic rating: ")
        return Integer.parseInt(readln())
    }

    /**
     * Display all warier and its available capabilities.
     */
    private fun display(list: List<Humanoid>, withDetail: Boolean) {
        list.forEachIndexed { index, warier ->
            val content = buildString {
                append(index + 1)
                append(". ")
                if (withDetail) append(warier) else {
                    append(warier.name)
                    append(" [")
                    append(if (warier.isAlive) "ALIVE" else "DEAD")
                    append(" ")
                    append(warier.javaClass.simpleName)
                    append(" ]")
                }
            }
            println(content)
        }
    }

    /**
     * Choose a warier if available or create new in some cases.
     */
    private fun chooseWarier(type: WarierType): Humanoid {
        var tempList = mutableListOf<Humanoid>()

        if (type == ANY_WARIER) tempList = warierList.toMutableList() else {
            warierList.forEach { warier ->
                when {
                    warier is Hobbit && type == HOBBIT -> tempList.add(warier)
                    warier is Elf && type == ELF -> tempList.add(warier)
                    warier is Wizard && type == WIZARD -> tempList.add(warier)
                }
            }
        }

        if (tempList.isEmpty()) {
            println("\nNo $type found, we will create for you.")

            val temp: Humanoid = when (type) {
                ELF -> Elf(Warier.name)
                HOBBIT -> Hobbit(Warier.name)
                WIZARD -> Wizard(Warier.name)
                else -> throw IllegalArgumentException("Invalid warier: $type")
            }

            warierList.add(temp)
            tempList.add(temp)
        }

        display(tempList, false)

        print("\nSelect $type: #")
        return tempList[Integer.parseInt(readln()) - 1]
    }

    /**
     * Create a warier with custom or random abilities.
     */
    private fun buildWarier(type: WarierType) {
        print("Create new $type with random abilities? (y/n): ")

        when (readln().lowercase()) {
            "y" -> warierList.add(
                when (type) {
                    HOBBIT -> Hobbit(Warier.name)
                    ELF -> Elf(Warier.name)
                    FIGHTER -> Fighter(Warier.name)
                    WIZARD -> Wizard(Warier.name)
                    HUMAN -> Human(Warier.name)
                    ANY_WARIER -> null
                } as Humanoid
            )

            "n" -> {
                print("\nEnter name: ")
                val name = readln()

                print("Enter strength: ")
                val strength = Integer.parseInt(readln())

                print("Enter dexterity: ")
                val dexterity = Integer.parseInt(readln())

                print("Enter armour: ")
                val armour = Integer.parseInt(readln())

                print("Enter moxie: ")
                val moxie = Integer.parseInt(readln())

                print("Enter coins: ")
                val coins = Integer.parseInt(readln())

                print("Enter health: ")
                val health = Integer.parseInt(readln())

                val other: Humanoid? = when (type) {
                    HUMAN, FIGHTER, WIZARD -> {
                        println("\nSelect your Elf enemy: ")
                        chooseWarier(ELF)
                    }

                    ELF -> {
                        println("\nSelect your Hobbit friend: ")
                        chooseWarier(HOBBIT)
                    }

                    else -> null
                }

                val warier = when (type) {
                    HOBBIT -> Hobbit(
                        name,
                        strength,
                        dexterity,
                        armour,
                        moxie,
                        coins,
                        health
                    )

                    ELF -> Elf(
                        name,
                        strength,
                        dexterity,
                        armour,
                        moxie,
                        coins,
                        health,
                        chooseClan(),
                        other as Hobbit
                    )

                    FIGHTER -> Fighter(
                        name,
                        strength,
                        dexterity,
                        armour,
                        moxie,
                        coins,
                        health,
                        other as Elf
                    )

                    WIZARD -> Wizard(
                        name,
                        strength,
                        dexterity,
                        armour,
                        moxie,
                        coins,
                        health,
                        other as Elf?,
                        mGetMagicRating()
                    )

                    HUMAN -> Human(
                        name,
                        strength,
                        dexterity,
                        armour,
                        moxie,
                        coins,
                        health,
                        other as Elf
                    )

                    ANY_WARIER -> null
                } as Humanoid

                warierList.add(warier)
            }
        }

        println("\n$type is Ready.\n")
    }

    /**
     * Quit the game
     */
    private fun quit(): Unit = exitProcess(status = 0)
}
