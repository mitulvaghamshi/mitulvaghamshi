package me.mitul.quizgame.helpers

import javafx.event.ActionEvent
import javafx.scene.control.Button

object ActionListener {
    private lateinit var callBack: ActionCallBack

    fun ActionCallBack.register() {
        callBack = this
    }

    fun onClick(event: ActionEvent) = callBack.call(event.source as Button)
}
