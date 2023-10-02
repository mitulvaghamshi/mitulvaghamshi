package src.models

/**
 * This class provides a model to create an object of type Human
 * it also allows to choose an enemy
 */
open class Human : Humanoid {
    /* a reference to the enemy */
    private val enemy: Elf

    /**
     * Single parameterized constructor to create a human with random abilities
     *
     * @param name it accepts name value
     */
    constructor(name: String?) : super(name) {
        enemy = Elf(this.name) // assign a new random enemy
    }

    /**
     * Multi parameterized constructor to create a new human with given values
     *
     * @param name      name of the human
     * @param strength  an integer strength value
     * @param dexterity an integer dexterity value
     * @param armour    an integer armour value
     * @param moxie     an integer moxie value
     * @param coins     an integer coins
     * @param health    an integer health value
     * @param enemy     a reference to the enemy object
     */
    constructor(
        name: String?,
        strength: Int,
        dexterity: Int,
        armour: Int,
        moxie: Int,
        coins: Int,
        health: Int,
        enemy: Elf,
    ) : super(name, strength, dexterity, armour, moxie, coins, health) {
        this.enemy = enemy
    }

    /**
     * An overridden toString method to represent an object into string
     *
     * @return String returns an String formatted object
     */
    override fun toString(): String = "${super.toString()} [ENEMY: ${enemy.name}]"
}
