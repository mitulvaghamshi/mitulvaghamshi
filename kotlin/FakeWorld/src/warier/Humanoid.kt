package warier

import java.util.*
import kotlin.math.max

private val rnd = Random()

private fun random(limit: Int) = rnd.nextInt(limit)

/**
 * Humanoid is a base structure for all warier.
 *
 * @param name      name of the humanoid
 * @param strength  strength
 * @param dexterity dexterity
 * @param armour    armour
 * @param moxie     moxie
 * @param coins     coins
 * @param health    health
 */
abstract class Humanoid(
    val name: String?,
    val dexterity: Int = random(21),
    private val strength: Int = random(21),
    private val armour: Int = random(20) + 1,
    private val moxie: Int = random(21),
    private var coins: Int = random(1000),
    private var health: Int = random(21),
) {
    /**
     * Check if Humanoid is dead or alive.
     * Alive Humanoids have health is greater than zero.
     *
     * @return boolean returns Humanoid life state
     */
    val isAlive; get() = health > 0

    /**
     * Increase coins
     *
     * @param coins number of coins to add
     */
    fun increaseCoins(coins: Int) {
        this.coins += coins
    }

    /**
     * Reduce coins
     *
     * @param coins number of coins to remove
     */
    fun reduceCoins(coins: Int) {
        this.coins = max(a = this.coins - coins, b = 0)
    }

    /**
     * Increase health
     *
     * @param health new health value
     */
    fun increaseHealth(health: Int) {
        this.health += health
    }

    /**
     * Reduce health
     *
     * @param health amount of health to reduce
     */
    fun reduceHealth(health: Int) {
        this.health = max(a = this.health - health, b = 0)
    }

    /**
     * Attack any Humanoid.
     * Only alive humanoids can attack, and attack on itself is avoided.
     * After successful attack, target will lose some health points.
     * Attack by Fighter will cause double damage then regular.
     *
     * @param other opponent Humanoid to attack.
     */
    fun attack(other: Humanoid) {
        if (!isAlive || equals(other)) return

        val powers = strength + dexterity + health
        val damageStrength = if (this is Fighter) 2 else 1
        val damage = powers / 3 * damageStrength / other.armour
        other.increaseHealth(-max(a = damage, b = 1))
    }

    /**
     * Pretty print Humanoid and its abilities.
     *
     * @return String returns a String formatted object
     */
    override fun toString() = String.format(
        FORMAT, name, if (isAlive) "ALIVE" else "DEAD",
        javaClass.simpleName,
        strength, dexterity, armour, moxie, coins, health
    )

    private companion object {
        private const val FORMAT =
            "%-10s [%-5s %-7s] [STR: %3d  DEX:  %3d  ARM:  %3d  MOX:  %3d] [COINS: %4d  HEALTH: %2d]"
    }
}
