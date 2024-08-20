fn main() {
    (1..=10).for_each(|i| println!("{}", fizzbuzz(i)));
}

/// ```rust
/// # use super::{fizzbuzz, is_divisible};
///
/// assert_eq!(fizzbuzz(2), "2");
/// assert_eq!(fizzbuzz(3), "fizz");
/// assert_eq!(fizzbuzz(5), "buzz");
/// assert_eq!(fizzbuzz(15), "fizzbuzz");
/// ```
fn fizzbuzz(n: u32) -> String {
    let fizz: &str = if is_divisible(n, 3) { "fizz" } else { "" };
    let buzz: &str = if is_divisible(n, 5) { "buzz" } else { "" };
    if fizz.is_empty() && buzz.is_empty() {
        return format!("{n}");
    }
    format!("{fizz}{buzz}")
}

/// ```rust
/// # use super::{fizzbuzz, is_divisible};
///
/// assert_eq!(is_divisible(0, 1), false);
/// assert_eq!(is_divisible(15, 5), is_divisible(15, 3));
/// ```
fn is_divisible(lhs: u32, rhs: u32) -> bool {
    if lhs == 0 {
        return false;
    }
    lhs % rhs == 0
}
