package me.mitul.quizgame

import javafx.application.Application
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
import me.mitul.quizgame.helpers.ActionCallBack
import me.mitul.quizgame.helpers.ActionListener.onClick
import me.mitul.quizgame.helpers.ActionListener.register
import me.mitul.quizgame.models.*

class QuizGame : Application(), ActionCallBack {
    private val bank = QuestionBank()
    private val result = Result()
    private var signBar: HBox? = null
    private var question: Label? = null

    init {
        this.register()
    }

    override fun call(button: Button?) {
        val answer = button?.text.equals(other = "true", ignoreCase = true) == bank.answer
        result.updateResult(answer)
        addResultSign(signBar!!, answer)
        bank.nextQuestion()
        if (bank.isFinished) {
            bank.setupQuestions()
            if (finishGame(result.trueAnswers, result.falseAnswers)) {
                signBar!!.children.clear()
                result.clear()
            } else {
                Platform.exit()
            }
        }
        question!!.text = bank.question
    }

    override fun start(stage: Stage) {
        stage.initStyle(StageStyle.UNDECORATED)
        stage.title = "Quiz Game"
        stage.scene = Scene(makeContent(), 1000.0, 650.0).apply {
            val style = QuizGame::class.java.getResource("style.css")?.toURI().toString()
            stylesheets.add(style)
        }
        stage.show()
    }

    private fun makeContent() = Pane(VBox().apply {
        spacing = 20.0
        alignment = Pos.CENTER
        signBar = makeSignBar()
        question = makeQuestion(bank.question)
        val answerButtons = makeButtonGroup(
            makeButton(true).apply { onAction = EventHandler(::onClick) },
            makeButton(false).apply { onAction = EventHandler(::onClick) }
        )
        children.addAll(
            makeCloseButton(),
            makeSpacer(width = 0.0, height = 20.0),
            question,
            makeSpacer(width = 0.0, height = 20.0),
            answerButtons,
            makeSpacer(width = 0.0, height = 20.0),
            signBar,
        )
    })
}

fun main() = Application.launch(QuizGame::class.java)
