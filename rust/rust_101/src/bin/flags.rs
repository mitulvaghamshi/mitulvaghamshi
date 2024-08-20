fn main() {
    const READ: u8 = 0b100;
    const WRITE: u8 = 0b010;
    const EXECUTE: u8 = 0b001;

    let permissions = READ | WRITE; // Combine permissions

    println!("Has read: {}", permissions & READ != 0);
    println!("Has write: {}", permissions & WRITE != 0);
    println!("Has execute: {}", permissions & EXECUTE != 0);
}
