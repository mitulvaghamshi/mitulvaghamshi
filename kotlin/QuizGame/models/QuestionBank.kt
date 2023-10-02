package models

/**
 * This class provides set of questions and its answer
 * it provides set of methods to access question set
 */
class QuestionBank {
    private val questionBank: List<Question>
    private var questionNumber = 0

    /**
     * Constructor to populate question list
     */
    init {
        questionBank = getQuestions()
    }

    /**
     * This method moves the pointer to next question up to length of question list
     */
    fun nextQuestion() {
        if (questionNumber < questionBank.size) questionNumber++
    }

    /**
     * This method provides question text
     *
     * @return question - it returns question at [questionNumber] position from the list
     */
    val questionText: String
        get() = questionBank[questionNumber].text

    /**
     * This method provides answer of current question
     *
     * @return answer - it returns answer of current questionNumber
     */
    val correctAnswer: Boolean
        get() = questionBank[questionNumber].answer

    /**
     * This method checks whether user completes all the question
     *
     * @return boolean - it returns whether all questions finished or not
     */
    val isFinished: Boolean
        get() = questionNumber >= questionBank.size

    /**
     * Reset the question pointer to zero
     * this occurs when user choose to play again
     */
    fun reset() {
        questionNumber = 0
    }

    /**
     * This method provides list of question and answer
     *
     * @return List<Question> - it returns set of question and answer
     */
    private fun getQuestions(): List<Question> = listOf(
        Question(
            text = "Some cats are actually allergic to humans",
            answer = true
        ),  // 1
        Question(
            text = "You can lead a cow down stairs but not up stairs.",
            answer = false
        ),  // 2
        Question(
            text = "Approximately one quarter of human bones are in the feet.",
            answer = true
        ),  // 3
        Question(
            text = "A slug\"s blood is green.",
            answer = true
        ),  // 4
        Question(
            text = "Buzz Aldrin\"s mother\"s maiden name was \"Moon\".",
            answer = true
        ),  // 5
        Question(
            text = "It is illegal to pee in the Ocean in Portugal.",
            answer = true
        ),  // 6
        Question(
            text = "No piece of square dry paper can be folded in half more than 7 times.",
            answer = false
        ),  // 7
        Question(
            text = "In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.",
            answer = true
        ),  // 8
        Question(
            text = "The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.",
            answer = false
        ),  // 9
        Question(
            text = "The total surface area of two human lungs is approximately 70 square metres.",
            answer = true
        ),  // 10
        Question(
            text = "Google was originally called \"Back-rub\".",
            answer = true
        ),  // 11
        Question(
            text = "Chocolate affects a dog\"s heart and nervous system; a few ounces are enough to kill a small dog.",
            answer = true
        ),  // 12
        Question(
            text = "In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.",
            answer = true
        ) // 13
    )
}
