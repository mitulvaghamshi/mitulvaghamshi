use crate::Ops;
use std::f32::consts::SQRT_2;

/// Implementation for Tetrahedron shape.
pub struct Tetrahedron {
    name: String,
    length: f32,
}

impl Tetrahedron {
    /// Initialize new shape instance using default
    /// implementation of get_input() from shape_ops::Ops trait.
    pub fn new() -> Self {
        Self {
            name: String::from("Tetrahedron"),
            length: Self::get_input("Length"),
        }
    }
}

/// Implementation of shape operation trait.
impl Ops for Tetrahedron {
    /// Calculates area of a Tetrahedron shape.
    /// Formula: 3^0.5 * length^2.
    /// Return: suarface area of a shape as float.
    fn calculate_area(&self) -> f32 {
        f32::sqrt(3.0) * f32::powf(self.length, 2.0)
    }

    /// Calculates volume of a Tetrahedron shape.
    /// Formula: 2^0.5 / 12 * length^3
    /// Return: volume of a shape as float.
    fn calculate_volume(&self) -> f32 {
        SQRT_2 / 12.0 * f32::powf(self.length, 3.0)
    }

    /// Display calculated area, volume, and other shape properties.
    fn print(&self) -> String {
        format!(
            "| {name:15} | {area:>10.2} | {volume:>10.2} | {props:>25} |",
            name = self.name,
            area = self.calculate_area(),
            volume = self.calculate_volume(),
            props = format_args!("{} l", self.length)
        )
    }
}
