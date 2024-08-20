use crate::Ops;

/// Implementation for Square shape.
pub struct Square {
    name: String,
    length: f32,
}

impl Square {
    /// Initialize new shape instance using default
    /// implementation of get_input() from shape_ops::Ops trait.
    pub fn new() -> Self {
        Self {
            name: String::from("Square"),
            length: Self::get_input("Length"),
        }
    }
}

/// Implementation of shape operation trait.
impl Ops for Square {
    /// Calculates area of a Square shape.
    /// Formula: length * length.
    /// Return: suarface area of a shape as float.
    fn calculate_area(&self) -> f32 {
        self.length * self.length
    }

    /// Display calculated area, volume, and other shape properties.
    fn print(&self) -> String {
        format!(
            "| {name:15} | {area:>10.2} | {volume:>10.2} | {props:>25} |",
            name = self.name,
            area = self.calculate_area(),
            volume = "",
            props = format_args!("{} l", self.length)
        )
    }
}
