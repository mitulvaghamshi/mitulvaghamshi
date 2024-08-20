package me.mitul.quizgame.models

class Result {
    var trueAnswers = 0; private set
    var falseAnswers = 0; private set

    fun updateResult(isTrue: Boolean) {
        if (isTrue) trueAnswers++ else falseAnswers++
    }

    fun clear() {
        trueAnswers = 0
        falseAnswers = 0
    }
}
