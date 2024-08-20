package warier

import java.util.*
import kotlin.math.max

/**
 * Create a Wizard which is a Human with healing power.
 */
class Wizard : Human {
    // Magic rating used to heal other Humanoids
    private var magicRating: Int

    /**
     * Create a Wizard with random abilities
     *
     * @param name name of the Wizard
     */
    constructor(name: String?) : super(name) {
        // Healing power between 0 and 20
        magicRating = Random().nextInt(21)
    }

    /**
     * Create a Wizard with given abilities
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
     * A Wizard can heal other Humanoids by increasing its health value.
     * Wizard will lose 3 points after each successful heal.
     * Wizard can heal only if it is alive and has healing power.
     * Wizard cannot heal itself.
     */
    fun heal(other: Humanoid) {
        if (!isAlive || magicRating <= 0 || equals(other)) return

        other.increaseHealth(health = magicRating / 2)
        magicRating = max(a = magicRating - 3, b = 0)
    }

    /**
     * Pretty print Wizard and its healing power.
     *
     * @return String returns a String formatted object
     */
    override fun toString() = "${super.toString()} [MAGIC: $magicRating]"
}
