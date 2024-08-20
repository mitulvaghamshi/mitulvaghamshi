use std::io::{self, Write};

pub trait Ops {
    fn print(&self) -> String;

    fn calculate_area(&self) -> f32 {
        unimplemented!()
    }

    fn calculate_volume(&self) -> f32 {
        unimplemented!()
    }

    fn get_input(label: &str) -> f32 {
        loop {
            print!("Enter the {label}: ");
            io::stdout().flush().ok();
            let mut input = String::with_capacity(4);
            if let Ok(_) = io::stdin().read_line(&mut input) {
                if let Ok(num) = input.trim().parse::<f32>() {
                    return num;
                }
            }
            println!("[ERROR]: Invalid input...");
        }
    }
}
