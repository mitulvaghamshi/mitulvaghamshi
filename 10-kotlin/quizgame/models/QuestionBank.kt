package me.mitul.quizgame.models

class QuestionBank {
    private var questionsList: ArrayList<Pair<String, Boolean>>
    private lateinit var pairIterator: Iterator<Pair<String, Boolean>>
    private lateinit var currentQuestion: Pair<String, Boolean>

    val question get() = currentQuestion.first
    val answer get() = currentQuestion.second
    val isFinished get() = !pairIterator.hasNext()

    init {
        questionsList = questions()
        setupQuestions()
        nextQuestion()
    }

    fun nextQuestion() {
        currentQuestion = pairIterator.next()
    }

    fun setupQuestions() {
        pairIterator = questionsList.iterator()
    }

    private fun questions() = arrayListOf(
        Pair(first = "Some cats are actually allergic to humans", second = true),  // 1

        Pair(first = "You can lead a cow down stairs but not up stairs.", second = false),  // 2
        Pair(first = "Approximately one quarter of human bones are in the feet.", second = true),  // 3
        Pair(first = "A slug's blood is green.", second = true),  // 4
        Pair(first = "Buzz Aldrin's mother's maiden name was 'Moon'.", second = true),  // 5
        Pair(first = "It is illegal to pee in the Ocean in Portugal.", second = true),  // 6
        Pair(
            first = "No piece of square dry paper can be folded in half more than 7 times.",
            second = false
        ),  // 7
        Pair(
            first = "In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.",
            second = true
        ),  // 8
        Pair(
            first = "The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.",
            second = false
        ), // 9
        Pair(
            first = "The total surface area of two human lungs is approximately 70 square metres.",
            second = true
        ),  // 10
        Pair(first = "Google was originally called 'Back-rub'.", second = true),  // 11
        Pair(
            first = "Chocolate affects a dog's heart and nervous system; a few ounces are enough to kill a small dog.",
            second = true
        ),// 12
        Pair(
            first = "In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.",
            second = true
        ),// 13
    )
}
