mod ops;
mod repo;
mod shape;

use ops::Ops;
use shape::Shape;

use repo::{Box, Cube, Cylinder, Sphere, Tetrahedron};
use repo::{Circle, Ellipse, Rectangle, Square, Triangle};
use std::io::{self, Write};

/// Create different geometry shapes.
fn main() {
    let mut shape_list = Vec::<Shape>::new();
    loop {
        println!("{PROMPT}");
        println!("{count} Shape(s) found.\n", count = shape_list.len());
        match get_choice() {
            Ok(0) => break,
            Ok(choice) => shape_list.push(Shape::new(&choice)),
            Err(error) => println!("{error}"),
        }
    }
    shape_list.iter().for_each(Shape::print);
}

fn get_choice() -> Result<i32, String> {
    print!("Enter your choice: ");
    io::stdout().flush().ok();
    let mut input = String::with_capacity(1);
    let Ok(_) = io::stdin().read_line(&mut input) else {
        return Err(format!("[Error]: Something went wrong."));
    };
    let Ok(choice) = input.trim().parse::<i32>() else {
        return Err(format!("[Error]: Enter a valid number."));
    };
    if 0 < choice && choice > 10 {
        return Err(format!("[INFO]: Enter value between 0 and 10."));
    };
    Ok(choice)
}

const PROMPT: &str = "Welcome to Geometry:\n\n1.  Rectangle\n2.  Square\n3.  Box\n4.  Cube\n5.  Ellipse\n6.  Circle\n7.  Cylinder\n8.  Sphere\n9.  Triangle\n10. Tetrahedron\n\n0.  List all shapes and exit.";
