package models

/**
 * This class keeps track of correct and wrong answers
 */
class Result {
    /**
     * Getter method to get number of correct answers
     *
     * @return trueAnswers - returns number of true answers
     */
    var trueAnswers = 0
        private set

    /**
     * Getter method to get number of wrong answers
     *
     * @return falseAnswers - returns number of false answers
     */
    var falseAnswers = 0
        private set

    /**
     * This method increments respective counter based on correctness of the answer
     *
     * @param isTrue - whether user choose correct or wrong answer
     */
    fun updateResult(isTrue: Boolean) {
        if (isTrue) trueAnswers++ else falseAnswers++
    }

    /**
     * This method resets all the counters to its initial position zero
     * it gets called when user choose to play again
     */
    fun clear() {
        trueAnswers = 0
        falseAnswers = 0
    }
}
