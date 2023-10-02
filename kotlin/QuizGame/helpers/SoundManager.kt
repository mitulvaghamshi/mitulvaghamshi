package helpers

import javafx.scene.media.Media
import javafx.scene.media.MediaPlayer
import java.io.File

/**
 * This class handles playing different sound effects
 */
object SoundManager {
    /* Reference to media file */
    private val trueSnd = Media(File("clips/true.mp3").toURI().toString())
    private val falseSnd = Media(File("clips/false.mp3").toURI().toString())
    private val finishSnd = Media(File("clips/finish.mp3").toURI().toString())

    /**
     * A static method to play respective sound based on event
     *
     * @param sounds - type of sound to play
     */
    @JvmStatic
    fun playSound(sounds: Sounds?) = MediaPlayer(
        when (sounds) {
            Sounds.TRUE -> trueSnd
            Sounds.FALSE -> falseSnd
            Sounds.FINISH -> finishSnd
            else -> throw IllegalArgumentException("Invalid Media: $sounds")
        }
    ).play()

    /* Types of event based sound */
    enum class Sounds { TRUE, FALSE, FINISH }
}
