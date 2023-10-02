package src.utils

import java.util.Random

/**
 * This class contains some constant values used frequently during the program
 * execution
 * all the method used here are static
 */

/* index counter to give every time new value */
private var nameIndex = 0

/* list of names */
private val names = arrayOf(
    "Fiorella", "Ambrogio", "Giacinto", "Demetrio", "Simonette", "Bernard",
    "Wilmar", "Waleed", "Albion", "Beatrice", "Merino", "Bronwen", "Edgardo",
    "Mauricio", "Alphonso", "Mario", "Barrett", "Afonso", "Apostolos"
)

/**
 * This method will used to get random name for the player
 * currently limited number of names used, but can be extended
 *
 * @return String it return a unique name for every new player
 */
fun getName(): String =
    names[if (nameIndex < names.size) nameIndex++ else 0.also { nameIndex = 0 }]

/**
 * This method used to get the clan value for the Elf
 *
 * @param index it accepts index value
 * @return String it returns clan value based on given index
 */
fun getClan(index: Int): String {
    return arrayOf("Forest", "City")[index]
}

/**
 * This method used to generate a random integer from given range
 *
 * @param value it accepts max bound value generate from
 * @return int returns a randomly generated integer value
 */
fun random(value: Int): Int = Random().nextInt(value)
