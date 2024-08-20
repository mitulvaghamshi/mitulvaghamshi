use crate::deck::Deck;
use std::{
    io::{self, Write},
    str::FromStr,
};

/// Creates a deck of cards to hold different cards
fn main() {
    let mut deck: Deck;
    // Get suit and rank value from the user
    loop {
        print!("How many suits? : ");
        let Some(suit) = get_input::<usize>() else {
            continue;
        };
        print!("How many ranks? : ");
        let Some(rank) = get_input::<usize>() else {
            continue;
        };
        // Initialize new deck of card with given value
        deck = Deck::new(suit, rank);
        break;
    }

    // Display game options to play the game, shuffle, deal or quit
    loop {
        // Show initial deck of card
        println!("-----------------------");
        println!("{}", deck.to_string());
        println!("-----------------------");
        println!("1. Shuffle");
        println!("2. Deal 1 hand");
        println!("3. Deal 100,000 times");
        println!("4. Exit");
        println!("-----------------------");
        print!("\nEnter your choice: ");

        match get_input() {
            Some(1) => deck.shuffle(),
            Some(2) => deal(&deck),
            Some(3) => histogram(&mut deck),
            Some(4) => break,
            _ => println!("[INFO]: Enter value between 1 and 4."),
        }
    }
    println!("Thank you! For playing...!");
}

/// This procedure is an implementation of deal method,
/// this will calls the actual deal method with required data
fn deal(deck: &Deck) {
    // Get number of cards to deal
    print!("How many cards? : ");
    let Some(number) = get_input::<usize>() else {
        return;
    };
    // Call the deal method and display cards to the user
    deck.deal(number).into_iter().for_each(|card| {
        println!("{}", card.to_string());
    });
}

/// This method calls the histogram method of the Deck,
/// it represents numerical data as histogram
fn histogram(deck: &mut Deck) {
    // Get the number of cards to deal
    print!("How many cards? : ");
    let Some(number) = get_input::<usize>() else {
        return;
    };
    println!("Please wait...");
    // Tracks non-zero records in histogram
    let mut counter = 0;
    // Call the histogram method that returns list of integers
    // Iterate over all the records in histogram list
    deck.histogram(number).into_iter().for_each(|item| {
        counter += 1;
        // If the record is non-zero then display it to the user
        if item % 1000 > 0 {
            // Display counter and card value in histogram
            print!("{counter}: {item} ");
            // Display an * (asterisk) for every 1000 number in a record
            (0..(item / 1000) / 2).for_each(|_| print!("*"));
            // A new line after each record
            println!();
        }
    });
}

/// Get and parse user input with error handling
fn get_input<T: FromStr>() -> Option<T> {
    io::stdout().flush().ok();
    let mut input = String::new();
    if let Err(_) = io::stdin().read_line(&mut input) {
        println!("[ERROR]: Enter a valid number!");
        return None;
    }
    let input = match input.trim().parse::<T>() {
        Ok(value) => value,
        Err(_) => {
            println!("[ERROR]: Enter a numaric value.");
            return None;
        }
    };
    Some(input)
}

mod card {
    use std::fmt::{Debug, Formatter, Result};

    /// Define a card with suit and rank
    ///
    /// Card(suit, rank);
    pub struct Card(usize, usize);

    /// # Examples
    ///
    /// ```
    /// use card_deck::card::Card;
    ///
    /// let card1 = Card::new(10, 20);
    /// let card2 = Card::new(20, 30);
    ///
    /// assert_ne!(card1, card2);
    ///
    /// assert_eq!(card1.suit(), 10);
    /// assert_eq!(card2.rank(), 30);
    /// assert_eq!(card1.rank(), card2.suit());
    /// ```
    impl Card {
        /// Creates new card for the deck of cards, it contains
        /// number of suits and ranks for the particular card.
        ///
        /// @param rank number of ranks for the card
        /// @param suit number of suits for the card
        pub fn new(suit: usize, rank: usize) -> Self {
            Self(suit, rank)
        }

        /// A public method to get rank value of a card
        ///
        /// @return rank - returns a number of ranks
        pub fn suit(&self) -> usize {
            self.0
        }

        /// A public method to get suit value of a card
        ///
        /// @return suit - returns a number of suits
        pub fn rank(&self) -> usize {
            self.1
        }
    }

    /// Create new card with existing card values.
    ///
    /// # Examples
    ///
    /// ```
    /// use card_deck::card::Card;
    ///
    /// let card1 = Card::new(10, 20);
    /// let card2 = Card::from(&card1);
    ///
    /// assert_eq!(card1, card2);
    /// ```
    impl From<&Card> for Card {
        fn from(card: &Card) -> Self {
            Self::new(card.0, card.1)
        }
    }

    /// An overridden method for card equality
    ///
    /// @return bool - returns whether both cards same or not
    ///
    /// # Examples
    ///
    /// ```
    /// use card_deck::card::Card;
    ///
    /// let card1 = Card::new(10, 20);
    /// let card2 = Card::new(10, 20);
    ///
    /// assert_eq!(card1, card2);
    /// ```
    impl PartialEq for Card {
        fn eq(&self, other: &Self) -> bool {
            self.0 == other.0 && self.1 == other.1
        }
    }

    impl Clone for Card {
        fn clone(&self) -> Self {
            Self(self.0.clone(), self.1.clone())
        }
    }

    /// An overridden method to display the card
    ///
    /// @return String - returns a card value as a string
    ///
    /// # Examples
    ///
    /// ```
    /// use card_deck::card::Card;
    ///
    /// let card = Card::new(10, 20);
    /// let result = String::from("S 10 R 20");
    ///
    /// assert_eq!(card.to_string(), result);
    /// ```
    impl ToString for Card {
        fn to_string(&self) -> String {
            format!("Card(S{} R{})", self.0, self.1)
        }
    }

    /// An overridden method to debug-print card
    ///
    /// Required by Doctest
    impl Debug for Card {
        fn fmt(&self, f: &mut Formatter<'_>) -> Result {
            f.debug_tuple("Card").field(&self.0).field(&self.1).finish()
        }
    }
}

mod deck {
    use super::card::Card;
    use rand::Rng;
    use std::collections::HashMap;

    // A list of card in a deck
    pub struct Deck {
        cards: Vec<Card>,
    }

    /// This class contains a list of cards,
    /// and a set of methods that manipulate cards
    ///
    /// @param rank - it holds the number of ranks entered by the user
    /// @param suit - it holds the number of suits entered by the user
    impl Deck {
        pub fn new(suit: usize, rank: usize) -> Self {
            // Maximum number of cards
            let size = suit * rank;
            // Create a new list of cards with size of rank time suit
            let mut cards = Vec::<Card>::with_capacity(size);
            // Create and initialize individual cards
            for i in 1..=suit {
                for j in 1..=rank {
                    cards.push(Card::new(i, j))
                }
            }
            Self { cards }
        }

        /// This method give the top most element of the list
        ///
        /// @return card - returns the card from first position of the list
        pub fn peek(&self) -> Result<&Card, String> {
            return if let Some(card) = self.cards.get(0) {
                Ok(card)
            } else {
                Err(String::from("No card found!"))
            };
        }

        /// This method is used to shuffle-up stack of cards,
        /// it uses random numbers to exchange card positions,
        /// this changes are permanent to the original list
        pub fn shuffle(&mut self) {
            let mut length = self.cards.len();
            let random = &mut rand::thread_rng();
            // Loop through the list and swap cards to random position
            while length > 0 {
                let i = random.gen_range(0..length);
                let j = random.gen_range(0..length);
                // Swap cards using built-in swap method.
                self.cards.swap(i, j);
                length -= 1;
            }
        }

        /// This method used to deal one hand on deck of cards
        /// it creates a copy of given number of elements
        /// return a copy of first [cardNumber] elements
        /// if number is bigger then size?, return all
        ///
        /// @param cardNumber - number of cards to deal
        /// @return card[] - returns an array of card with first n elements
        pub fn deal(&self, count: usize) -> Vec<Card> {
            self.cards[0..count.min(self.cards.len())].to_vec()
        }

        /// This method used to create histogram for every cards
        /// it loop through hundred thousand times and calculate value of each card
        /// it calls its deal and shuffle method at every loop
        ///
        /// @param cardNumber - number of cards to deal
        /// @return histogram[] - returns an array of integer containing card value
        pub fn histogram(&mut self, count: usize) -> Vec<u32> {
            // Maximum size of histogram list
            let mut size = 0;
            // Iterate over all the elements in card list
            self.cards.iter().for_each(|card| {
                // Sum of product of rank and suit of each card
                size += (card.rank() * card.suit()) as usize;
            });

            // Create new histogram list
            let mut histogram = HashMap::<usize, u32>::with_capacity(size);
            // Loop 100,000 times
            (0..100_000).for_each(|_| {
                // Sum of all the deal cards
                let mut sum = 0;
                // Call deal method and iterate over its returned card list
                self.deal(count).into_iter().for_each(|card| {
                    // Add card value to the sum
                    sum += card.suit() * card.rank();
                });
                // Increment histogram at sum index by one
                let count = histogram.entry(sum - 1).or_insert(0);
                *count += 1;
                // Call shuffle for every iteration
                self.shuffle();
            });

            histogram.into_values().collect()
        }
    }

    /// An overridden method to describe an object of this class with its properties
    /// it shows size of deck with its high, low and top positioned card
    ///
    /// @return string - returns a string base description of deck
    impl ToString for Deck {
        fn to_string(&self) -> String {
            let size = self.cards.len();
            let top_card = match self.peek() {
                Ok(card) => card.to_string(),
                Err(err) => err,
            };
            format!(
                "Deck of {size} cards:\nLow: {low} High: {size}\nTop: {top_card}",
                low = if size > 0 { 1 } else { 0 }
            )
        }
    }
}
