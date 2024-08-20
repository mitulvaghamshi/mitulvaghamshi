package utils

private val names = listOf(
    "Fiorella", "Ambrogio", "Giacinto", "Demetrio", "Simonette", "Bernard",
    "Wilmar", "Waleed", "Albion", "Beatrice", "Merino", "Bronwen", "Edgardo",
    "Mauricio", "Alphonso", "Mario", "Barrett", "Afonso", "Apostolos",
)

enum class WarierType { HOBBIT, ELF, FIGHTER, WIZARD, HUMAN, ANY_WARIER }

class Warier {
    /**
     * Type of different warier.
     */

    companion object {
        private var warierNames = names.iterator()

        /**
         * Get random name for a warier.
         *
         * @return String a name for every new warier.
         */
        val name: String
            get() {
                if (!warierNames.hasNext()) warierNames = names.iterator()
                return warierNames.next()
            }
    }
}
