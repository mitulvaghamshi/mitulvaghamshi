package src.models

import src.utils.random
import kotlin.math.max

/**
 * This class act as a parent class for all other model classes
 * this is an abstract class means all child classes have override the behaviour
 * of this class
 */
abstract class Humanoid
/**
 * Single parameterized constructor to create a new humanoid with random
 * abilities
 *
 * @param name it accepts name value
 */ @JvmOverloads constructor(
    /**
     * getter method to get name
     *
     * @return String it returns name of the humanoid
     */
    /* name of the humanoid */
    val name: String?,
    /* strength of the humanoid */
    private val strength: Int = random(21),
    /**
     * getter method to get dexterity value of the humanoid
     *
     * @return int it returns dexterity of the humanoid
     */
    /* dexterity of the humanoid */
    val dexterity: Int = random(21),
    /**
     * getter method to get armour value of the humanoid
     *
     * @return int it returns the armour value of the humanoid
     */
    /* armour of the humanoid */
    private val armour: Int = random(20) + 1,
    /* moxie of the humanoid */
    private val moxie: Int = random(21), /* coins for the humanoid */
    private var coins: Int = random(1000), /* health of the humanoid */
    private var health: Int = random(21),
) {

    /**
     * Multi parameterized constructor to create a new humanoid with given values
     *
     * @param name      name of the humanoid
     * @param strength  an integer strength value
     * @param dexterity an integer dexterity value
     * @param armour    an integer armour value
     * @param moxie     an integer moxie value
     * @param coins     an integer coins
     * @param health    an integer health value
     */
    /**
     * This method is used to update coins of a humanoid
     *
     * @param coins it accepts number of coins to add or remove
     */
    fun updateCoins(coins: Int) {
        this.coins = max(this.coins - coins, 0)
    }

    /**
     * This method used to update health value of a humanoid
     *
     * @param health it accepts health value to update
     */
    fun updateHealth(health: Int) {
        this.health = max(this.health + health, 0)
    }

    /**
     * This method will check whether the humanoid is alive or dead
     * alive humanoids have health value greater then zero
     *
     * @return boolean it returns true or false stating whether the humanoid is
     * alive or dead
     */
    val isAlive: Boolean
        get() = health > 0

    /**
     * This method used to attack any humanoid
     * only alive humanoids can attack, attack on itself avoided
     * after successful attack, target will lose some health points
     * attack by fighter will cause double damage then regular
     *
     * @param other it accepts reference to the other humanoid to attack
     */
    fun attack(other: Humanoid) {
        if (isAlive && !equals(other)) other.updateHealth(
            -max(
                (strength + dexterity + health) / 3 * if (this is Fighter) 2 else 1 / other.armour,
                1
            )
        )
    }

    /**
     * An overridden toString method to represent an object into string
     *
     * @return String returns an String formatted object
     */
    override fun toString(): String = String.format(
        "%-10s [%-5s %-7s] [STR: %3d  DEX:  %3d  ARM:  %3d  MOX:  %3d] [COINS: %4d  HEALTH: %2d]",
        name,
        if (isAlive) "ALIVE" else "DEAD",
        javaClass.simpleName,
        strength,
        dexterity,
        armour,
        moxie,
        coins,
        health
    )
}
