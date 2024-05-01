package warier

/**
 * Create a Human which is a Humanoid and choose an Elf enemy.
 */
open class Human : Humanoid {
    private val enemy: Elf

    /**
     * Create a Human with random abilities and an enemy
     *
     * @param name it accepts name value
     */
    constructor(name: String?) : super(name) {
        enemy = Elf(this.name)
    }

    /**
     * Create a Human with given abilities
     *
     * @param name      name of this Human
     * @param strength  strength
     * @param dexterity dexterity
     * @param armour    armour
     * @param moxie     moxie
     * @param coins     coins
     * @param health    health
     * @param enemy     an Elf enemy
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
     * Pretty print Human and its enemy's name
     *
     * @return String returns a String formatted object
     */
    override fun toString() = "${super.toString()} [ENEMY: ${enemy.name}]"
}
