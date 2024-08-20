use crate::Ops;
use std::f32::consts::PI;

/// Implementation for Ellipse shape.
pub struct Ellipse {
    name: String,
    semi_major: f32,
    semi_minor: f32,
}

impl Ellipse {
    /// Initialize new shape instance using default
    /// implementation of get_input() from shape_ops::Ops trait.
    pub fn new() -> Self {
        Self {
            name: String::from("Ellipse"),
            semi_major: Self::get_input("Semi Major Length"),
            semi_minor: Self::get_input("Semi Minor Length"),
        }
    }
}

/// Implementation of shape operation trait.
impl Ops for Ellipse {
    /// Calculates area of a Ellipse shape.
    /// Formula: PI * semi_major * semi_minor.
    /// Return: suarface area of a shape as float.
    fn calculate_area(&self) -> f32 {
        PI * self.semi_major * self.semi_minor
    }

    /// Display calculated area, volume, and other shape properties.
    fn print(&self) -> String {
        format!(
            "| {name:15} | {area:>10.2} | {volume:>10.2} | {props:>25} |",
            name = self.name,
            area = self.calculate_area(),
            volume = "",
            props = format_args!("{} major x {} minor", self.semi_major, self.semi_minor)
        )
    }
}
