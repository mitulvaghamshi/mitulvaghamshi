package src.models

import src.utils.getClan
import java.util.Random

/**
 * This class provides a model to create an object of type Elves
 * it also allows to choose a friend
 */
class Elf : Humanoid {
    // where this character live
    private val clan: String

    // reference of the friend
    private var friend: Hobbit

    /**
     * Single parameterized constructor to create an elf with random abilities
     *
     * @param name it accepts name value
     */
    constructor(name: String?) : super(name) {
        clan = getClan(Random().nextInt(2)) // get clan value
        friend = Hobbit(src.utils.getName()) // create a new random player
    }

    /**
     * Multi parameterized constructor to create a new elf with given values
     *
     * @param name      name of the elf
     * @param strength  an integer strength value
     * @param dexterity an integer dexterity value
     * @param armour    an integer armour value
     * @param moxie     an integer moxie value
     * @param coins     an integer coins
     * @param health    an integer health value
     * @param clan      a string clan
     * @param friend    a reference to the friend object
     */
    constructor(
        name: String?,
        strength: Int,
        dexterity: Int,
        armour: Int,
        moxie: Int,
        coins: Int,
        health: Int,
        clan: String,
        friend: Hobbit,
    ) : super(name, strength, dexterity, armour, moxie, coins, health) {
        this.clan = clan
        this.friend = friend
    }

    /**
     * This method used to change an existing friend
     *
     * @param friend reference to new friend
     */
    fun friendOf(friend: Hobbit) {
        this.friend = friend
    }

    /**
     * An overridden toString method to represent an object into string
     *
     * @return String returns an String formatted object
     */
    override fun toString(): String = "${super.toString()} [CLAN: $clan FRIEND: ${friend.name}]"
}
