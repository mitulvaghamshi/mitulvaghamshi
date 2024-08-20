package me.mitul.quizgame.helpers

import javafx.scene.media.Media
import javafx.scene.media.MediaPlayer
import java.io.File

object SoundManager {
    enum class Sounds { TRUE, FALSE, FINISH }

    private const val PATH =  "src/main/kotlin/me/mitul/quizgame/clips"

    private val trueSnd = Media(File("$PATH/true.mp3").toURI().toString())
    private val falseSnd = Media(File("$PATH/false.mp3").toURI().toString())
    private val finishSnd = Media(File("$PATH/finish.mp3").toURI().toString())

    private val truePlayer = MediaPlayer(trueSnd)
    private val falsePlayer = MediaPlayer(falseSnd)
    private val finishPlayer = MediaPlayer(finishSnd)

    @JvmStatic
    fun playSound(sounds: Sounds) = when (sounds) {
        Sounds.TRUE -> truePlayer
        Sounds.FALSE -> falsePlayer
        Sounds.FINISH -> finishPlayer
    }.play()
}
