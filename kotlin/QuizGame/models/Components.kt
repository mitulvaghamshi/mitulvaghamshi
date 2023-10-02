package models

import javafx.application.Platform
import javafx.event.EventHandler
import javafx.scene.control.Alert
import javafx.scene.control.Button
import javafx.scene.control.ButtonBar
import javafx.scene.control.ButtonType
import javafx.scene.control.Label
import javafx.scene.control.Tooltip
import javafx.scene.layout.HBox
import javafx.scene.layout.Pane
import helpers.SoundManager.Sounds
import helpers.SoundManager.playSound

/**
 * Create a [Label] with question text
 *
 * @param questionText - a text to display on [Label]
 * @return label   - returns a [Label] with styled text
 */
fun makeQuestion(questionText: String?): Label = Label(questionText).apply {
    styleClass.add("question")
    isWrapText = true
}

/**
 * Creates a empty space (black area)
 *
 * @param width  - width of the space
 * @param height - height of the space
 * @return pane  - returns a [Pane] component with specified width and height
 */
fun makeSpacer(width: Double, height: Double): Pane = Pane().apply {
    setPrefSize(width, height)
}

/**
 * This method creates a sign with tick mark
 *
 * @param isTrue - whether to create a true or false sign
 * @return label - returns a label with styled tick mark
 */
private fun makeSign(isTrue: Boolean): Label = Label(if (isTrue) "✔" else "✘").apply {
    tooltip = Tooltip("Your answer is: $isTrue")
    styleClass.addAll("sign", if (isTrue) "true" else "false")
}

/**
 * This creates an exit button that displayed at top of
 * the window to close the program
 *
 * @return button - returns a styled button to close the program
 */
fun makeCloseButton(): Button = Button("✘").apply {
    tooltip = Tooltip("Exit Quiz")
    style = "-fx-text-fill: #000000;"
    onAction = EventHandler { Platform.exit() }
}

/**
 * Creates a styled button
 *
 * @param sign - whether to create a True or False button
 * @return - returns new button
 */
fun makeButton(sign: Boolean): Button = Button(if (sign) "True" else "False").apply {
    tooltip = Tooltip(text)
    styleClass.addAll("btn", if (sign) "true" else "false")
}

/**
 * It creates a horizontal box that contains true and false buttons
 *
 * @param buttons - a list of buttons to add to the box
 * @return buttonBox - returns a styled box containing buttons
 */
fun makeButtonGroup(vararg buttons: Button?): HBox = HBox().apply {
    spacing = 150.0
    prefWidth = 1000.0
    style = "-fx-alignment: CENTER;"
    children.addAll(*buttons)
}

/**
 * Creates a horizontal bar to hold all the answer status
 *
 * @return signBar - returns a box to store signs
 */
fun makeSignBar(): HBox = HBox().apply {
    style = "-fx-alignment: CENTER;"
    prefWidth = 1000.0
}

/**
 * This method add a sign to the signBar every
 * time user clicks a button, true or false
 *
 * @param box  - a reference to the box to add sign in
 * @param sign - specifies which sign to add, true or false
 */
fun addResultSign(box: HBox, sign: Boolean) {
    playSound(if (sign) Sounds.TRUE else Sounds.FALSE)
    box.children.add(makeSign(sign))
}

/**
 * This method gets called when user finish answering all the questions
 *
 * @param trueAnswers  - number of correct answers
 * @param falseAnswers - number of wrong answers
 * @return boolean - returns whether to play again or quit the game
 */
fun finishGame(trueAnswers: Int, falseAnswers: Int): Boolean {
    // play completion sound
    playSound(Sounds.FINISH)
    // check is corrects are outweigh the wrongs
    val passed = trueAnswers > falseAnswers
    // create a standard alert dialog showing result and choice
    val alert = Alert(if (passed) Alert.AlertType.INFORMATION else Alert.AlertType.ERROR)
    alert.title = "Quiz Complete!" // set title of the dialog
    // display result
    alert.headerText = "Result: True: %d, False: %d\n%s".formatted(
        trueAnswers,
        falseAnswers,
        if (passed) "Well tried...!" else "Better luck next time...!"
    )
    // ask for user choice
    alert.contentText = "Would you like to play again?"
    alert.width = 200.0
    alert.height = 200.0
    // create button to restart the game
    val btnYes = ButtonType("Yes", ButtonBar.ButtonData.YES)
    // create button to quit the game
    val btnExit = ButtonType("Exit Game", ButtonBar.ButtonData.FINISH)
    // add buttons to dialog
    alert.buttonTypes.setAll(btnYes, btnExit)
    // show dialog and return user choice
    return alert.showAndWait().get() == btnYes
}

