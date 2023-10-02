package src.models

/**
 * This class provides a model to create an object of type Hobbit
 */
class Hobbit : Humanoid {
    /**
     * Single parameterized constructor to create an Hobbit with random abilities
     *
     * @param name it accepts name value
     */
    constructor(name: String?) : super(name)

    /**
     * Multi parameterized constructor to create a new Hobbit with given values
     *
     * @param name      name of the hobbit
     * @param strength  an integer strength value
     * @param dexterity an integer dexterity value
     * @param armour    an integer armour value
     * @param moxie     an integer moxie value
     * @param coins     an integer coins
     * @param health    an integer health value
     */
    constructor(
        name: String?,
        strength: Int,
        dexterity: Int,
        armour: Int,
        moxie: Int,
        coins: Int,
        health: Int,
    ) : super(name, strength, dexterity, armour, moxie, coins, health)

    /**
     * This method allows Hobbit to steal money from other humanoids
     * only alive hobbits can steal, and a hobbit can not steal from itself
     *
     * @param other it accepts reference to other Humanoid to steal money from
     */
    fun stealFrom(other: Humanoid) {
        if (isAlive && !equals(other)) { // check whether hobbit is not itself and also alive
            val coins = dexterity / 2 // calculate coins to steal
            other.updateCoins(-coins) // decrease coins of other humanoid
            updateCoins(coins) // increase coins of this hobbit
        }
    }
}
