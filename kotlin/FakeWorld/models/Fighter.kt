package src.models

/**
 * This class provides a model to create an object of type Fighter
 */
class Fighter : Human {
    /**
     * Single parameterized constructor to create Fighter with random abilities
     *
     * @param name it accepts name value
     */
    constructor(name: String?) : super(name)

    /**
     * Multi parameterized constructor to create a new Fighter with given values
     *
     * @param name      name of the Fighter
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
    ) : super(name, strength, dexterity, armour, moxie, coins, health, enemy)
}
