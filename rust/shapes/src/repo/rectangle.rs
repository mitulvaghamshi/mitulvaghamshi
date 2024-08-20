use crate::Ops;

/// Implementation for Rectangle shape.
pub struct Rectangle {
    name: String,
    length: f32,
    height: f32,
}

impl Rectangle {
    /// Initialize new shape instance using default
    /// implementation of get_input() from shape_ops::Ops trait.
    pub fn new() -> Self {
        Self {
            name: String::from("Rectangle"),
            length: Self::get_input("Length"),
            height: Self::get_input("Height"),
        }
    }
}

/// Implementation of shape operation trait.
impl Ops for Rectangle {
    /// Calculates area of a Rectangle shape.
    /// Formula: length * height.
    /// Return: suarface area of a shape as float.
    fn calculate_area(&self) -> f32 {
        self.length * self.height
    }

    /// Display calculated area, volume, and other shape properties.
    fn print(&self) -> String {
        format!(
            "| {name:15} | {area:>10.2} | {volume:>10.2} | {props:>25} |",
            name = self.name,
            area = self.calculate_area(),
            volume = "",
            props = format_args!("{} l x {} h", self.length, self.height)
        )
    }
}
