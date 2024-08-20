use std::io::{self, Write};

fn main() {
    let mut bank: QuestionBank = QuestionBank::new();
    let mut result: Result = Result::default();

    while !bank.is_finished() {
        println!("{}", bank.get_question());
        print!("Enter your answer (T)rue)/(F)alse: ");
        io::stdout().flush().ok();
        let mut input: String = String::new();
        if let Ok(_) = io::stdin().read_line(&mut input) {
            let answer: bool = input.trim().to_lowercase().starts_with("t");
            result.update(bank.get_answer() == answer);
            bank.move_to_next();
        }
    }

    println!(
        "Correct: {}, Wrong: {}, Result: {}",
        result.get_true_count(),
        result.get_false_count(),
        result.get_result(),
    );

    bank.reset();
    result.reset();
}

/// This class store the result of the game of current player
/// It provides number of methods to modify the game result.
#[derive(Default)]
struct Result(/* true_count */ i32, /* false_count */ i32);

impl Result {
    /// Get count of true answers.
    fn get_true_count(&self) -> i32 {
        self.0
    }

    /// Get count of false answers.
    fn get_false_count(&self) -> i32 {
        self.1
    }

    /// Get game result based on comparision of true and false answers.
    fn get_result(&self) -> String {
        if self.0 > self.1 {
            String::from("You Won :)")
        } else {
            String::from("You Lose :(")
        }
    }

    /// Update result counters.
    fn update(&mut self, result: bool) {
        if result {
            self.0 += 1
        } else {
            self.1 += 1
        }
    }

    /// Clear the result counters to zero.
    fn reset(&mut self) {
        self.0 = 0;
        self.1 = 0;
    }
}

/// This class will create an instance a single question and its answer.
struct Question(/* question */ String, /* answer */ bool);

impl Question {
    /// Create new Question with its answer.
    fn new(text: String, answer: bool) -> Self {
        Self(text, answer)
    }
}

/// This class create a list of questions with its answers
/// and provides a set of method to retrieve questions.
struct QuestionBank {
    index: usize,
    count: usize,
    items: Vec<Question>,
}

impl QuestionBank {
    /// Get question text.
    fn get_question(&self) -> &str {
        &self.items[self.index].0
    }

    /// Get the original answer of the question.
    fn get_answer(&self) -> bool {
        self.items[self.index].1
    }

    /// Update question pointer if next question is available.
    fn move_to_next(&mut self) {
        if self.index < self.count {
            self.index += 1
        }
    }

    /// Check if all questions are used from the list.
    fn is_finished(&self) -> bool {
        self.index >= self.count
    }

    /// Reset question pointer to point first question.
    fn reset(&mut self) {
        self.index = 0
    }
}

impl QuestionBank {
    fn new() -> Self {
        let items: Vec<Question> = Self::load_questions();
        Self {
            index: 0,
            count: items.len(),
            items,
        }
    }

    /// Load/Prepare Questions.
    fn load_questions() -> Vec<Question> {
        vec![
            Question::new(String::from("Some cats are actually allergic to humans"), true), // 1
            Question::new(String::from("You can lead a cow down stairs but not up stairs."), false), // 2
            Question::new(String::from("Approximately one quarter of human bones are in the feet."), true), // 3
            Question::new(String::from("A slug's blood is green."), true), // 4
            Question::new(String::from("Buzz Aldrin's mother's maiden name was 'Moon'."), true), // 5
            Question::new(String::from("It is illegal to pee in the Ocean in Portugal."), true), // 6
            Question::new(String::from("No piece of square dry paper can be folded in half more than 7 times."), false), // 7
            Question::new(String::from("In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place."), true), // 8
            Question::new(String::from("The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant."), false), // 9
            Question::new(String::from("The total surface area of two human lungs is approximately 70 square metres."), true), // 10
            Question::new(String::from("Google was originally called 'Backrub'."), true), // 11
            Question::new(String::from("Chocolate affects a dog's heart and nervous system; a few ounces are enough to kill a small dog."), true), // 12
            Question::new(String::from("In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat."), true) // 13
        ]
    }
}
