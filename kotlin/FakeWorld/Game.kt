package src

import src.models.Elf
import src.models.Fighter
import src.models.Hobbit
import src.models.Human
import src.models.Humanoid
import src.models.Wizard
import src.utils.PlayerType
import src.utils.PlayerType.ANY_PLAYER
import src.utils.PlayerType.ELF
import src.utils.PlayerType.FIGHTER
import src.utils.PlayerType.HOBBIT
import src.utils.PlayerType.HUMAN
import src.utils.PlayerType.WIZARD
import src.utils.PlayerType.values
import src.utils.getClan
import src.utils.getName
import kotlin.system.exitProcess

/**
 * The class [Game] used to create a new game
 * and provides basic functionalities to play the game,
 * This treats model classes as a game player and try to create a simple game
 * It utilizes functionality all all the model classes to create and play this
 * game
 * It allows user to create and manipulate almost all the stuff of the game
 */
class Game {
    /* A list of base class [Humanoid] to hold all the players in the game */
    private val playerList = mutableListOf<Humanoid>()

    /**
     * This method is the starting point of the game
     * It gets called repeatedly until user choose to quit
     * The basic function of this method is to show user a list of options,
     * and asks to choose what they want to do
     */
    fun run() {
        println("----------------------")
        println("1. Create new player")
        println("2. Start a fight")
        println("3. Steal money")
        println("4. Heal player")
        println("5. Change friend")
        println("6. View Player List")
        println("7. Exit!")
        print("\nEnter your choice: #")
        when (Integer.parseInt(readln())) {
            1 -> createPlayer()
            2 -> createAttack()
            3 -> stealMoney()
            4 -> healPlayer()
            5 -> changeFriend()
            6 -> showPlayerFrom(playerList, true)
            7 -> quit()
            else -> println("Invalid option!!!")
        }
        // a recursive call to this method, until user quit
        run()
    }

    /**
     * This method allows user to create a new player with available choices
     * the choices are from list of model classes
     * after creating a new player it shows back to the user
     * by default all the player are allowed to attack and defend internally
     * and some of them are also have unique capabilities
     */
    private fun createPlayer() {
        println("All players - can attack and defend") // All the players [classes] are derived
        println("1. Hobbits  - can steal money") // from [Humanoid]
        println("2. Elves    - can have a patron or be a rival") // from [Humanoid]
        println("3. Fighter  - can double attack") // from [Human -> Humanoid]
        println("4. Wizard   - can heal") // from [Human -> Humanoid]
        println("5. Human    - easy life") // from [Humanoid]
        print("\nSelect a player type: #")
        buildPlayer(values()[Integer.parseInt(readln()) - 1]) // create a player
        showPlayerFrom(playerList, true) // show all the players with its abilities
    }

    /**
     * This method allows user to create a new attack between two players
     * It asks user to choose two players an attacker and a defender from the list
     * of available players
     * after successful attack defender will lose some health points, while attacker
     * doesn't gain anything
     * and finally it shows the defender a second player with its new values.
     * Note: calling this method supported by all the players classes, dead player
     * can not attack
     */
    private fun createAttack() {
        val attacker = choosePlayer(ANY_PLAYER) // select an attacker
        val defender = choosePlayer(ANY_PLAYER) // select a target player to attack
        attacker.attack(defender) // perform attack
        println(defender) // show the second player
    }

    /**
     * This method allows user to let one player to steal money from another player
     * user have to select two players one who steal and another to steal from
     * the first player will gain some coins, while another lose
     * finally it shows both the players with its new values
     * Note: only player from [Hobbit] class can allowed to call this method, dead
     * players can not steal
     */
    private fun stealMoney() {
        val hobbit = choosePlayer(HOBBIT) as Hobbit // select first player from Hobbit
        val other = choosePlayer(ANY_PLAYER) // select second player from any Humanoid
        hobbit.stealFrom(other) // perform steal
        println(hobbit) // show the first and second player
        println(other) // with its updated values
    }

    /**
     * This method allows user to let one player with healing capability to heal
     * another player
     * this will increase the health of any player and make them alive from dead
     * condition
     * user have to select two player one from [Wizard] class and another from any
     * [Humanoid]
     * after healing completes, the second player will gain some health, while first
     * lose some magic ratings
     * Note: only wizard has access to this method.
     */
    private fun healPlayer() {
        val wizard = choosePlayer(WIZARD) as Wizard // select first player from Wizard
        val other = choosePlayer(ANY_PLAYER) // select second player from any Humanoid
        wizard.healTo(other) // perform healing
        println(wizard) // show both the players
        println(other) // with new values
    }

    /**
     * This method intended to change the friend player
     * it will asks user to select first player from Elf class and second from
     * hobbit class
     * Note: the first player must be from any Elves, while second player is from
     * Hobbit class only
     * finally it shows first player with its new friend
     */
    private fun changeFriend() {
        val elf = choosePlayer(ELF) as Elf // select first player from Wizard
        val hobbit = choosePlayer(HOBBIT) as Hobbit // select second player from Hobbit
        elf.friendOf(hobbit) // change the friend
        println(elf) // show first player with new friend
    }

    /**
     * This method helps in building a player of any class
     * It allows user to create a player random or user given abilities,
     * for user given values it asks user to input all the required fields to create
     * a new player
     *
     * @param type type is the type of the player from available Humanoids
     */
    private fun buildPlayer(type: PlayerType) {
        // ask to create a random player
        print("Create new $type with random abilities? (y/n): ")
        when (readln().lowercase()) {
            "y" -> playerList.add(
                when (type) {
                    HOBBIT -> Hobbit(getName())
                    ELF -> Elf(getName())
                    FIGHTER -> Fighter(getName())
                    WIZARD -> Wizard(getName())
                    HUMAN -> Human(getName())
                    ANY_PLAYER -> null
                } as Humanoid
            )

            "n" -> { // if the user choose to create their own,
                print("\nEnter name: ") //
                val name = readln() // get player name
                print("Enter strength: ") //
                val strength = Integer.parseInt(readln()) // get player strength
                print("Enter dexterity: ") //
                val dexterity = Integer.parseInt(readln()) // get dexterity
                print("Enter armour: ") //
                val armour = Integer.parseInt(readln()) // get armour
                print("Enter moxie: ") //
                val moxie = Integer.parseInt(readln()) // get moxie
                print("Enter coins: ") //
                val coins = Integer.parseInt(readln()) // get coins
                print("Enter health: ") //
                val health = Integer.parseInt(readln()) // get health

                // this part only used for specific players
                val other: Humanoid? = when (type) {
                    HUMAN, FIGHTER, WIZARD -> {
                        // ask user to choose enemy from Elves
                        println("\nSelect your enemy(Elves only): ")
                        // get Elf and assign to temporary variable
                        choosePlayer(ELF)
                    }

                    ELF -> {
                        // ask user to choose friend from Hobbits
                        println("\nSelect your friend(Hobbits only): ")
                        // get Hobbit and assign to temporary variable
                        choosePlayer(HOBBIT)
                    }

                    else -> null
                }

                // create new player with the values entered
                val player = when (type) {
                    HOBBIT -> Hobbit(name, strength, dexterity, armour, moxie, coins, health)

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

                    ANY_PLAYER -> null
                } as Humanoid
                playerList.add(player)
            }
        }
        // notify user that player created
        println("\nNew $type created successfully!!!\n")
    }

    /**
     * This helper method used to get clan value for the Elves players
     * it asks user to select from two given choices
     *
     * @return String it returns the string value of users choice
     */
    private fun chooseClan(): String {
        println("\nSelect clan: ")
        println("1. Forest")
        println("2. City")
        return getClan(Integer.parseInt(readln()) - 1) // get value from with helper method
    }

    /**
     * This helper method used by Wizard players
     * to get magic rating value
     *
     * @return int it will returns magic rating value entered by the user
     */
    private fun mGetMagicRating(): Int {
        print("Enter magic rating: ")
        return Integer.parseInt(readln())
    }

    /**
     * This method will displays all the players created by the user
     *
     * @param list       it accepts the list of players to display from
     * @param withDetail it accepts a boolean value used to display player with full
     * or partial values
     */
    private fun showPlayerFrom(list: List<Humanoid>, withDetail: Boolean) {
        var count = 0
        // loop through the list of players and print a formatted output
        for (player in list) println(
            "${++count}. " + if (withDetail) player
            else "${player.name} [${
                if (player.isAlive) "ALIVE" else "DEAD"
            } ${player.javaClass.simpleName}]"
        )
    }

    /**
     * This method used to choose the player of desired type from the list
     * this is a multi purpose method which also creates a random player if required
     *
     * @param type it accepts type of player to select from the list
     * @return Humanoid it returns a selected player
     */
    private fun choosePlayer(type: PlayerType): Humanoid {
        var tempList = mutableListOf<Humanoid>() // temporary list of players
        if (type != ANY_PLAYER) { // if user choose to get any specific type of player
            for (player in playerList)  // loop through all the players and add it to the temporary list if,
                if (player is Hobbit && type == HOBBIT) tempList.add(player) // the player is Hobbit
                else if (player is Elf && type == ELF) tempList.add(player) // the player is Elf
                else if (player is Wizard && type == WIZARD) tempList.add(player) // the player is Wizard
        } else tempList = playerList.toMutableList() // add all the player to the list otherwise
        if (tempList.isEmpty()) { // if list does not contain required player,
            println("\nSorry!!! no $type available") // tell the user
            println("New random $type created!!!") // that the new
            val temp: Humanoid = when (type) {
                ELF -> Elf(getName())
                HOBBIT -> Hobbit(getName())
                WIZARD -> Wizard(getName())
                else -> throw IllegalArgumentException("Invalid player type: $type")
            }
            playerList.add(temp) // and add it to
            tempList.add(temp) // both the list
        }
        showPlayerFrom(tempList, false) // show filtered players with their names only
        print("\nSelect $type: #") // ask user to select any
        return tempList[Integer.parseInt(readln()) - 1] // return selected one from the list
    }

    /**
     * If user choose to quit the game
     */
    private fun quit(): Unit = exitProcess(0)
}
