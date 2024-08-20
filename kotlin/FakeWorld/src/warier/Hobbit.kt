package warier

/**
 * Create a Hobbit which is a Humanoid
 */
class Hobbit : Humanoid {
    /**
     * Create a Hobbit with random abilities
     *
     * @param name name of the Hobbit
     */
    constructor(name: String?) : super(name)

    /**
     * Create a Hobbit with given abilities
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
     * Hobbit can steal money from other Humanoids Hobbits.
     * Only alive Hobbits can steal, and stealing from itself is not allowed.
     *
     * @param other Humanoid to steal money from
     */
    fun stealFrom(other: Humanoid) {
        if (!isAlive || equals(other)) return

        val coins = dexterity / 2 // calculate coins to steal
        other.reduceCoins(coins)  // decrease coins of other Humanoid
        increaseCoins(coins)      // increase coins of this Hobbit
    }
}
