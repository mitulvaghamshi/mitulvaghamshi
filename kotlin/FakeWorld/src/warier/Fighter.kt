package warier

/**
 * Create a Fighter which is a Human
 */
class Fighter : Human {
    /**
     * Create Fighter with random abilities
     *
     * @param name name of the Fighter
     */
    constructor(name: String?) : super(name)

    /**
     * Create a Fighter with given abilities
     *
     * @param name      name of the Fighter
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
    ) : super(name, strength, dexterity, armour, moxie, coins, health, enemy)
}
