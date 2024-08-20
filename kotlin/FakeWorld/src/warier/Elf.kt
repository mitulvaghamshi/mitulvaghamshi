package warier

import utils.Warier
import java.util.*

/**
 * Create an Elf which is a Humanoid with its Hobbit friend
 */
class Elf : Humanoid {
    // Elf's residence
    private val clan: String

    // Current friend
    private var friend: Hobbit

    /**
     * Create an Elf with random abilities and a friend
     *
     * @param name it accepts name value
     */
    constructor(name: String?) : super(name) {
        clan = getResidence()
        friend = Hobbit(Warier.name)
    }

    /**
     * Create am Elf and its Friend with given abilities
     *
     * @param name      name of the elf
     * @param strength  an integer strength value
     * @param dexterity an integer dexterity value
     * @param armour    an integer armour value
     * @param moxie     an integer moxie value
     * @param coins     an integer coins
     * @param health    an integer health value
     * @param clan      a string clan
     * @param friend    a reference to the friend object
     */
    constructor(
        name: String?,
        strength: Int,
        dexterity: Int,
        armour: Int,
        moxie: Int,
        coins: Int,
        health: Int,
        clan: String,
        friend: Hobbit,
    ) : super(name, strength, dexterity, armour, moxie, coins, health) {
        this.clan = clan
        this.friend = friend
    }

    /**
     * Change an existing friend
     *
     * @param friend a new Hobbit friend
     */
    fun becomeFriendOf(friend: Hobbit) {
        this.friend = friend
    }

    /**
     * Pretty print Elf and its friend's name
     *
     * @return String returns a String formatted object
     */
    override fun toString() = "${super.toString()} [CLAN: $clan FRIEND: ${friend.name}]"

    companion object {
        /**
         * Get Elf's (residence).
         *
         * @return String returns residence
         */
        @JvmStatic
        fun getResidence(preferCity: Boolean = Random().nextBoolean()) =
            if (preferCity) "City" else "Forest"
    }
}
