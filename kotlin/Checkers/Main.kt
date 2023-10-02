import javafx.application.Application
import javafx.application.Application.launch
import javafx.scene.Scene
import javafx.scene.layout.Pane
import javafx.stage.Stage
import Constants.BOARD_SIZE

/**
 * This class creates a CheckerBoard object and starts a new game
 */
class Main : Application() {
    /**
     * Start method (use this instead of default).
     * @param stage The FX stage to draw on
     */
    override fun start(stage: Stage) = with(Checkers()) {
        stage.title = "Checkers" // window title
        stage.scene = Scene(Pane(getSidePane(), tileGroup, pieceGroup)
            .apply { setPrefSize(BOARD_SIZE + 300, BOARD_SIZE) })
        stage.show()
    }
}

/**
 * The actual main method that launches the app.
 */
fun main() = launch(Main().javaClass)
