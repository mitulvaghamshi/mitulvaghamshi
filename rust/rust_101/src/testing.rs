pub mod sample_tests {
    /// Calculate the sum of the 2D vector.
    ///
    /// @param data input 2D array.
    /// @return the sum of all values.
    ///
    /// ```
    /// # use self::sum_2d_vector;
    ///
    /// assert_eq!(sum_2d_vector(&vec![vec![]]), 0);
    /// assert_eq!(sum_2d_vector(&vec![vec![1,2,3],vec![4,5,6],vec![7,8,9]]), 45);
    /// ```
    pub fn sum_2d_vector(data: &Vec<Vec<i32>>) -> i32 {
        let mut sum = 0;
        data.into_iter().for_each(|row| {
            row.into_iter().for_each(|col| {
                sum += col;
            });
        });
        sum
    }

    /// Caluclate the row with the highest sum.
    ///
    /// @param data input 2D vector.
    /// @return both the highest_row_sum and highest_row_number in array of 2 elements.
    ///
    /// ```
    /// # use testing::highest_row_sum;
    ///
    /// assert_eq!(highest_row_sum(&vec![vec![1,2,3],vec![7,8,9],vec![4,5,6]]), (1, 24));
    /// assert_eq!(highest_row_sum(&vec![vec![10,20,30],vec![4,5,6],vec![7,8,9]]), (0, 60));
    /// ```
    pub fn highest_row_sum(data: &Vec<Vec<i32>>) -> (i32, i32) {
        let mut highest_row_sum = i32::MIN;
        let mut highest_row_number = -1;
        data.into_iter().for_each(|row| {
            let mut row_sum = 0;
            row.into_iter().for_each(|col| {
                row_sum += col;
            });
            if row_sum > highest_row_sum {
                highest_row_sum = row_sum;
                highest_row_number += 1;
            }
        });
        (highest_row_number, highest_row_sum)
    }

    /// Efficient Prime determination - O(sqrt(N)) where N = value.
    ///
    /// @param numaric value.
    /// @return boolean result as true or false.
    ///
    /// ```
    /// # use testing::is_prime;
    ///
    /// assert_eq!(is_prime(2), true);
    /// assert_eq!(is_prime(7), true);
    /// assert_eq!(is_prime(11), true);
    /// assert_eq!(is_prime(8), false);
    /// assert_eq!(is_prime(1), false);
    /// assert_eq!(is_prime(9), false);
    /// ```
    pub fn is_prime(value: i32) -> bool {
        // Base cases
        if value == 1 {
            // 1 can only be divided by one number, 1 itself.
            return false;
        } else if value == 2 {
            // Two is a prime because it is divisible by only two and one.
            return true;
        } else if value % 2 == 0 {
            return false;
        }
        let sqrt_of_value = (value as f32).sqrt() as i32;
        let mut i = 3;
        while i <= sqrt_of_value {
            if value % i == 0 {
                return false;
            }
            i += 1;
        }
        true
    }

    /// Determines if a value is a prime number - BRUTE FORCE - O(N) where N = value.
    ///
    /// @param numaric value.
    /// @return boolean result as true or false.
    ///
    /// ```
    /// # use testing::is_prime_old;
    ///
    /// assert_eq!(is_prime_old(2), true);
    /// assert_eq!(is_prime_old(7), true);
    /// assert_eq!(is_prime_old(11), true);
    /// assert_eq!(is_prime_old(8), false);
    /// assert_eq!(is_prime_old(1), false);
    /// assert_eq!(is_prime_old(9), false);
    /// ```
    pub fn is_prime_old(value: i32) -> bool {
        if value == 1 {
            // 1 can only be divided by one number, 1 itself.
            return false;
        }
        let mut i = 2;
        while i < value {
            if value % i == 0 {
                return false;
            }
            i += 1;
        }
        true
    }
}

pub mod undo_redo {
    struct Stack {
        total: i32,
        undos: Vec<i32>,
        redos: Vec<i32>,
    }

    /// Create an empty stack.
    ///
    /// # Test new method. Should create an empty stack.
    ///
    /// ```rust
    /// # use rust_101::undo_redo::Stack;
    ///
    /// let mut stack = Stack::new();
    /// assert_eq!(stack.total(), 0, "[testing new]: Does not match the result, Extected: 0, Found: {}", stack.total());
    ///
    /// stack.undo();
    /// assert_eq!(stack.total(), 0, "[testing new + undo]: Does not match the result, Extected: 0, Found: {}", stack.total());
    ///
    /// stack.redo();
    /// assert_eq!(stack.total(), 0, "[testing new + redo]: Does not match the result, Extected: 0, Found: {}", stack.total());
    /// ```
    impl Stack {
        pub fn new() -> Self {
            Self {
                total: 0,
                undos: Vec::new(),
                redos: Vec::new(),
            }
        }

        pub fn total(&self) -> i32 {
            self.total
        }
    }

    impl Stack {
        /// Add given value to the total,
        /// and record the action to the history stack.
        ///
        /// # Test add method. Should add a number to total.
        ///
        /// ```rust
        /// # use rust_101::undo_redo::Stack;
        ///
        /// let mut stack = Stack::new();
        ///
        /// stack.add(2); // 2
        /// stack.add(5); // 7
        ///
        /// assert_eq!(stack.total(), 7, "[testing add]: Does not match the result, Extected: 7, Found: {}", stack.total());
        /// ```
        pub fn add(&mut self, value: i32) {
            self.total += value;
            self.undos.push(value);
        }

        /// Sub given value from the total,
        /// and record the action to the history stack.
        ///
        /// # Test sub method. Should subtract a number from total.
        ///
        /// ```rust
        /// # use rust_101::undo_redo::Stack;
        ///
        /// let mut stack = Stack::new();
        ///
        /// stack.sub(2); // -2
        /// stack.sub(5); // -7
        ///
        /// assert_eq!(stack.total(), -7, "[testing sub]: Does not match the result, Extected: -7, Found: {}", stack.total());
        /// ```
        pub fn sub(&mut self, value: i32) {
            self.total -= value;
            self.undos.push(-value);
        }

        /// Undo last action and update the current total,
        /// and mark this action to be redo-able.
        ///
        /// # Test undo method. Should undo last step, and reflects the total.
        ///
        /// ```rust
        /// # use rust_101::undo_redo::Stack;
        ///
        /// let mut stack = Stack::new();
        ///
        /// stack.add(2); // 2
        /// stack.add(2); // 4
        ///
        /// stack.sub(2); // 2
        /// stack.sub(2); // 0
        ///
        /// stack.add(2); // 2
        /// stack.add(2); // 4
        ///
        /// stack.undo(); // 2
        ///
        /// assert_eq!(stack.total(), 2, "[testing undo]: Does not match the result, Extected: 2, Found: {}", stack.total());
        /// ```
        pub fn undo(&mut self) {
            if let Some(value) = self.undos.pop() {
                self.total -= value;
                self.redos.push(value);
            }
        }

        /// Redo last action and update the current total,
        /// and mark this action to be undo-able.
        ///
        /// # Test redo method. Should redo last step, and reflects the total.
        ///
        /// ```rust
        /// # use rust_101::undo_redo::Stack;
        ///
        /// let mut stack = Stack::new();
        ///
        /// stack.add(2); // 2
        /// stack.add(2); // 4
        /// stack.add(2); // 6
        ///
        /// stack.sub(2); // 4
        ///
        /// stack.undo(); // 6
        /// stack.redo(); // 4
        ///
        /// assert_eq!(stack.total(), 4, "[testing redo]: Does not match the result, Extected: 4, Found: {}", stack.total());
        /// ```
        pub fn redo(&mut self) {
            if let Some(value) = self.redos.pop() {
                self.add(value);
            }
        }

        /// Bulk-undo last actions and update the current total,
        /// and mark this action to be redo-able.
        ///
        /// # Test undo_last method. Should undo last specified steps.
        ///
        /// ```rust
        /// # use rust_101::undo_redo::Stack;
        ///
        /// let mut stack = Stack::new();
        ///
        /// stack.add(1); // 1
        ///
        /// stack.sub(1); // 0
        ///
        /// stack.add(1); // 1
        /// stack.add(1); // 2
        /// stack.add(1); // 3
        ///
        /// stack.sub(1); // 2
        /// stack.sub(1); // 1
        ///
        /// stack.add(1); // 2
        /// stack.add(1); // 3
        ///
        /// stack.sub(1); // 2
        ///
        /// stack.undo_last(4); // 2
        ///
        /// assert_eq!(stack.total(), 2, "[testing undo_last]: Does not match the result, Extected: 2, Found: {}", stack.total());
        /// ```
        pub fn undo_last(&mut self, steps: usize) {
            (0..usize::min(self.undos.len(), steps)).for_each(|_| self.undo());
        }

        /// Bulk-redo last actions and update the current total,
        /// and mark this action to be undo-able.
        ///
        /// # Test redo_last method. Should redo last specified steps.
        ///
        /// ```rust
        /// # use rust_101::undo_redo::Stack;
        ///
        /// let mut stack = Stack::new();
        ///
        /// stack.add(1); // 1
        /// stack.add(1); // 2
        /// stack.add(1); // 3
        ///
        /// stack.sub(1); // 2
        ///
        /// stack.add(1); // 3
        ///
        /// stack.sub(1); // 2
        ///
        /// stack.add(1); // 3
        /// stack.add(1); // 4
        ///
        /// stack.sub(1); // 3
        /// stack.sub(1); // 2
        ///
        /// stack.add(1); // 3
        /// stack.add(1); // 4
        ///
        /// stack.undo_last(4); // 4
        ///
        /// stack.redo_last(4); // 4
        ///
        /// assert_eq!(stack.total(), 4, "[testing redo_last]: Does not match the result, Extected: 2, Found: {}", stack.total());
        /// ```
        pub fn redo_last(&mut self, steps: usize) {
            (0..usize::min(self.redos.len(), steps)).for_each(|_| self.redo());
        }
    }

    /// Testing under and over steps.
    #[cfg(test)]
    mod tests {
        use super::Stack;

        #[test]
        #[should_panic(expected = "Explicit panic!")]
        fn test_panic() {
            panic!("Explicit panic!");
        }

        #[test]
        fn test_no_action_undo() {
            let mut stack = Stack::new();
            stack.undo(); // 0
            stack.undo(); // 0
            stack.undo(); // 0
            assert_eq!(
                stack.total(),
                0,
                "[testing no action undo]: Does not match the result, Extected: 0, Found: {}",
                stack.total()
            );
        }

        #[test]
        fn test_no_action_redo() {
            let mut stack = Stack::new();
            stack.add(2); // 2
            stack.add(5); // 7
            stack.redo(); // 7
            stack.redo(); // 7
            stack.redo(); // 7
            assert_eq!(
                stack.total(),
                7,
                "[testing no action redo]: Does not match the result, Extected: 7, Found: {}",
                stack.total()
            );
        }

        #[test]
        fn test_over_step_undo() {
            let mut stack = Stack::new();
            stack.add(1); // 1
            stack.add(1); // 2
            stack.add(1); // 3
            stack.add(1); // 4
            stack.add(1); // 5
            stack.undo_last(20); // 0
            assert_eq!(
                stack.total(),
                0,
                "[testing over step undo]: Does not match the result, Extected: 0, Found: {}",
                stack.total()
            );
        }

        #[test]
        fn test_over_step_redo() {
            let mut stack = Stack::new();
            stack.add(1); // 1
            stack.add(1); // 2
            stack.add(1); // 3
            stack.add(1); // 4
            stack.add(1); // 5
            stack.undo_last(2); // 3
            stack.redo_last(10); // 5
            assert_eq!(
                stack.total(),
                5,
                "[testing over step redo]: Does not match the result, Extected: 5, Found: {}",
                stack.total()
            );
        }
    }
}

pub mod str_iter {
    fn prefix_matches(prefix: &str, request_path: &str) -> bool {
        if prefix.len() > request_path.len() {
            return false;
        }
        let mut p_iter = prefix.chars();
        let mut r_iter = request_path.chars();
        loop {
            let Some(p) = p_iter.next() else { break };
            let Some(r) = r_iter.next() else { break };
            if p == '*' {
                loop {
                    let Some(r) = r_iter.next() else { break };
                    if r == '/' {
                        p_iter.next();
                        break;
                    }
                }
            } else if p != r {
                return false;
            }
        }
        if let Some(r) = r_iter.next() {
            return r == '/';
        }
        true
    }

    fn prefix_matches_google(prefix: &str, request_path: &str) -> bool {
        let mut request_segments = request_path.split('/');
        for prefix_segment in prefix.split('/') {
            let Some(request_segment) = request_segments.next() else {
                return false;
            };
            if request_segment != prefix_segment && prefix_segment != "*" {
                return false;
            }
        }
        true
    }

    #[cfg(test)]
    mod tests {
        use super::prefix_matches;

        #[test]
        fn test_matches_without_wildcard() {
            assert!(prefix_matches("/v1/publishers", "/v1/publishers"));
            assert!(prefix_matches("/v1/publishers", "/v1/publishers/abc-123"));
            assert!(prefix_matches("/v1/publishers", "/v1/publishers/abc/books"));

            assert!(!prefix_matches("/v1/publishers", "/v1"));
            assert!(!prefix_matches("/v1/publishers", "/v1/publishersBooks"));
            assert!(!prefix_matches("/v1/publishers", "/v1/parent/publishers"));
        }

        #[test]
        fn test_matches_with_wildcard() {
            assert!(prefix_matches(
                "/v1/publishers/*/books",
                "/v1/publishers/foo/books"
            ));
            assert!(prefix_matches(
                "/v1/publishers/*/books",
                "/v1/publishers/bar/books"
            ));
            assert!(prefix_matches(
                "/v1/publishers/*/books",
                "/v1/publishers/foo/books/book1"
            ));

            assert!(!prefix_matches("/v1/publishers/*/books", "/v1/publishers"));
            assert!(!prefix_matches(
                "/v1/publishers/*/books",
                "/v1/publishers/foo/booksByAuthor"
            ));
        }
    }
}

pub mod caluclator {
    /// An operation to perform on two subexpressions.
    #[derive(Debug)]
    pub enum Opr {
        Add,
        Sub,
        Mul,
        Div,
    }

    /// An expression, in tree form.
    #[derive(Debug)]
    pub enum Expr {
        /// An operation on two subexpressions.
        Op {
            op: Opr,
            left: Box<Expr>,
            right: Box<Expr>,
        },
        /// A literal value
        Value(i64),
    }

    /// The result of evaluating an expression.
    #[derive(Debug, PartialEq, Eq)]
    pub enum Res {
        /// Evaluation was successful, with the given result.
        Ok(i64),
        /// Evaluation failed, with the given error message.
        Err(String),
    }

    pub fn eval(e: Expr) -> Res {
        match e {
            Expr::Op { op, left, right } => {
                let a = match eval(*left) {
                    Res::Ok(a) => a,
                    err => return err,
                };
                let b = match eval(*right) {
                    Res::Ok(b) => b,
                    err => return err,
                };
                Res::Ok(match op {
                    Opr::Add => a + b,
                    Opr::Sub => a - b,
                    Opr::Mul => a * b,
                    Opr::Div if b == 0 => return Res::Err(format!("division by zero")),
                    Opr::Div => a / b,
                })
            }
            Expr::Value(value) => Res::Ok(value),
        }
    }

    #[cfg(test)]
    mod test {
        use super::{eval, Expr, Opr, Res};

        #[test]
        fn test_value() {
            assert_eq!(eval(Expr::Value(19)), Res::Ok(19));
        }

        #[test]
        fn test_sum() {
            assert_eq!(
                eval(Expr::Op {
                    op: Opr::Add,
                    left: Box::new(Expr::Value(10)),
                    right: Box::new(Expr::Value(20)),
                }),
                Res::Ok(30)
            );
        }

        #[test]
        fn test_error() {
            assert_eq!(
                eval(Expr::Op {
                    op: Opr::Div,
                    left: Box::new(Expr::Value(99)),
                    right: Box::new(Expr::Value(0)),
                }),
                Res::Err(String::from("division by zero"))
            );
        }

        #[test]
        fn test_recursion() {
            let term1 = Expr::Op {
                op: Opr::Mul,
                left: Box::new(Expr::Value(10)),
                right: Box::new(Expr::Value(9)),
            };
            let term2 = Expr::Op {
                op: Opr::Mul,
                left: Box::new(Expr::Op {
                    op: Opr::Sub,
                    left: Box::new(Expr::Value(3)),
                    right: Box::new(Expr::Value(4)),
                }),
                right: Box::new(Expr::Value(5)),
            };
            assert_eq!(
                eval(Expr::Op {
                    op: Opr::Add,
                    left: Box::new(term1),
                    right: Box::new(term2),
                }),
                Res::Ok(85)
            );
        }
    }
}

pub mod credit_card {
    /// Luhn Algorithm (https://en.wikipedia.org/wiki/Luhn_algorithm)
    ///
    /// The Luhn algorithm is used to validate credit card numbers.
    /// The algorithm takes a string as input and does the following to validate the credit card number:
    ///
    /// - Ignore all spaces. Reject number with less than two digits.
    /// - Moving from right to left, double every second digit: for the number 1234, we double 3 and 1. For the number 98765, we double 6 and 8.
    /// - After doubling a digit, sum the digits if the result is greater than 9. So doubling 7 becomes 14 which becomes 1 + 4 = 5.
    /// - Sum all the undoubled and doubled digits.
    /// - The credit card number is valid if the sum ends with 0.
    ///
    fn luhn(cc_number: &str) -> bool {
        if cc_number.trim().len() < 2 {
            return false;
        }
        let mut sum = 0;
        let mut flag = true;
        for (i, c) in cc_number.replace(" ", "").chars().rev().enumerate() {
            let Some(num) = c.to_digit(10) else {
                return false;
            };
            sum += if i % 2 == 0 {
                num
            } else {
                let num = num * 2;
                if num > 9 {
                    num / 10 + num % 10
                } else {
                    num
                }
            };
            flag = !flag;
        }
        sum % 10 == 0
    }

    #[cfg(test)]
    mod test {
        use crate::testing::credit_card::luhn;

        #[test]
        fn test_non_digit_cc_number() {
            assert!(!luhn("foo"));
            assert!(!luhn("foo 0 0"));
        }

        #[test]
        fn test_empty_cc_number() {
            assert!(!luhn(""));
            assert!(!luhn(" "));
            assert!(!luhn("  "));
            assert!(!luhn("    "));
        }

        #[test]
        fn test_single_digit_cc_number() {
            assert!(!luhn("0"));
        }

        #[test]
        fn test_two_digit_cc_number() {
            assert!(luhn(" 0 0 "));
        }

        #[test]
        fn test_valid_cc_number() {
            assert!(luhn("4263 9826 4026 9299"));
            assert!(luhn("4539 3195 0343 6467"));
            assert!(luhn("7992 7398 713"));
        }

        #[test]
        fn test_invalid_cc_number() {
            assert!(!luhn("4223 9826 4026 9299"));
            assert!(!luhn("4539 3195 0343 6476"));
            assert!(!luhn("8273 1232 7352 0569"));
        }
    }
}
