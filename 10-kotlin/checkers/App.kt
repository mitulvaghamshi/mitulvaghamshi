package me.mitul.checkers

import javafx.application.Application
import javafx.scene.Scene
import javafx.scene.layout.Pane
import javafx.stage.Stage
import me.mitul.checkers.Constants.BOARD_SIZE

class App : Application() {
    /**
     * Start method (use this instead of default).
     * @param stage The FX stage to draw on
     */
    override fun start(stage: Stage) {
        val board = Board()
        val panel = Pane(board.tileGroup, board.pieceGroup)
        panel.setPrefSize(BOARD_SIZE, BOARD_SIZE)
        stage.scene = Scene(panel)
        stage.title = "Checkers"
        stage.show()
    }
}

fun main() = Application.launch(App::class.java)
