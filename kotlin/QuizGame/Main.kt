import javafx.application.Application
import javafx.application.Application.launch
import javafx.application.Platform
import javafx.event.EventHandler
import javafx.geometry.Pos
import javafx.scene.Scene
import javafx.scene.control.Button
import javafx.scene.control.Label
import javafx.scene.layout.HBox
import javafx.scene.layout.Pane
import javafx.scene.layout.VBox
import javafx.stage.Stage
import javafx.stage.StageStyle
import helpers.AddSignCallBack
import helpers.OnClickListener
import helpers.OnClickListener.handler
import models.QuestionBank
import models.Result
import models.addResultSign
import models.finishGame
import models.makeButton
import models.makeButtonGroup
import models.makeCloseButton
import models.makeQuestion
import models.makeSignBar
import models.makeSpacer

/**
 * The [Main] class creates a graphical user interface to play a quiz game
 * It extends [Application] class that provides graphics functionalities
 */
class Main : Application(), AddSignCallBack {
    private val questionBank = QuestionBank()
    private val result = Result()

    private var question: Label? = null
    private var signBar: HBox? = null // A horizontal container that shows result

    init {
        OnClickListener.register(this)
    }

    /**
     * This an implementation of [addSign] method from [AddSignCallBack] interface
     * This method used to:
     * - add answer sign (true/false) to the sign bar
     * - check if question is over
     * - keep track of questions to display
     * - update result variables
     * - display final result
     * - restart game from beginning
     * - fetch new question from question bank
     * - quit the game if user choose to
     *
     * @param button - a reference to which button is clicked
     */
    override fun addSign(button: Button?) {
        /* check user answer with original one in question bank */
        val answer = button?.text.equals("true", ignoreCase = true) == questionBank.correctAnswer
        result.updateResult(answer) // update respective result variable
        addResultSign(signBar!!, answer) // all new sign (true/false) to the sign bar
        questionBank.nextQuestion() // point ot the next question
        /* if user attempted all the questions */
        if (questionBank.isFinished) {
            questionBank.reset() // reset counter
            /* show result and check if user chose to play again or exit */
            if (finishGame(result.trueAnswers, result.falseAnswers)) {
                signBar!!.children.clear() // clear (true/false) signed bar
                result.clear() // reset answer variables to zero
            } else {
                Platform.exit() // quit game and exit the program by design
            }
        }
        question!!.text = questionBank.questionText // get new question from question bank
    }

    /**
     * This method initialize the components and start the application
     * it creates a window of 1000 x 650 pixels without title bar
     *
     * @param stage - A top level JavaFX container
     */
    override fun start(stage: Stage) {
        stage.initStyle(StageStyle.UNDECORATED) // hide title bar
        stage.title = "Quiz Game" // set the window title here
        stage.scene = Scene(makeContent(), 1000.0, 650.0).apply {
            stylesheets.add("styles/style.css") // link external stylesheet
        }
        stage.show() // show application
    }

    /**
     * This method build the GUI components
     */
    private fun makeContent(): Pane = Pane(VBox().apply {
        // create new vertical flowed container
        spacing = 20.0 // add top space (padding like)
        alignment = Pos.CENTER // center all the content
        signBar = makeSignBar() // true/false sign bar
        question = makeQuestion(questionBank.questionText)
        // true and false button container
        val answerButtons = makeButtonGroup(
            makeButton(true).apply { onAction = EventHandler { obj -> handler(obj) } },
            makeButton(false).apply { onAction = EventHandler { obj -> handler(obj) } }
        )
        children.addAll(
            makeCloseButton(),
            makeSpacer(0.0, 20.0),
            question,
            makeSpacer(0.0, 20.0),
            answerButtons,
            makeSpacer(0.0, 20.0),
            signBar,
        )
    })
}

/**
 * Entry point of the program
 */
fun main() = launch(Main().javaClass)
