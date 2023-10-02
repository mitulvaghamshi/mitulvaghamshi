package src.models

import src.utils.random
import kotlin.math.max

/**
 * This class provides a model to create an object of type Wizard
 * it also allows to assign magic rating value
 */
class Wizard : Human {
    /* magic rating used to heal other humanoids */
    private var magicRating: Int

    /**
     * Single parameterized constructor to create a new wizard with random abilities
     *
     * @param name it accepts name value
     */
    constructor(name: String?) : super(name) {
        magicRating = random(21) // assign new magic rating between 0 to 20
    }

    /**
     * Multi parameterized constructor to create a new wizard with given values
     *
     * @param name        name of the wizard
     * @param strength    an integer strength value
     * @param dexterity   an integer dexterity value
     * @param armour      an integer armour value
     * @param moxie       an integer moxie value
     * @param coins       an integer coins
     * @param health      an integer health value
     * @param enemy       a reference to the enemy object
     * @param magicRating an integer magic rating value
     */
    constructor(
        name: String?,
        strength: Int,
        dexterity: Int,
        armour: Int,
        moxie: Int,
        coins: Int,
        health: Int,
        enemy: Elf?,
        magicRating: Int,
    ) : super(name, strength, dexterity, armour, moxie, coins, health, enemy!!) {
        this.magicRating = magicRating
    }

    /**
     * This method of the wizard class used to heal other player
     * it will increase the health value of other Humanoid
     * and looses 3 points after each successful healing
     * wizard can heal only if it is alive and its magic rating is grater then zero
     */
    fun healTo(other: Humanoid) {
        if (isAlive && !equals(other) && magicRating > 0) {
            other.updateHealth(magicRating / 2)
            magicRating = max(magicRating - 3, 0)
        }
    }

    /**
     * An overridden toString method to represent an object into string
     *
     * @return String returns an String formatted object
     */
    override fun toString(): String = "${super.toString()} [MAGIC: $magicRating]"
}
