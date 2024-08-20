mod ops;
mod repo;
mod shape;

use ops::Ops;
use repo::{Box, Cube, Cylinder, Sphere, Tetrahedron};
use repo::{Circle, Ellipse, Rectangle, Square, Triangle};
use shape::Shape;
use std::io::{self, Write};

fn main() {
    let mut shape_list = Vec::<Shape>::new();
    loop {
        println!("{PROMPT}");
        println!(
            "{count} Shape{plural} found.\n",
            count = shape_list.len(),
            plural = if shape_list.len() == 1 { "" } else { "s" }
        );
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

const PROMPT: &str = r#"Welcome to Geometry:

1.  Rectangle
2.  Square
3.  Box
4.  Cube
5.  Ellipse
6.  Circle
7.  Cylinder
8.  Sphere
9.  Triangle
10. Tetrahedron

0.  List all shapes and exit.
"#;
