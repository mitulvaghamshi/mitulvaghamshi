use crate::Ops;
use std::f32::consts::PI;

/// Implementation for Circle shape.
pub struct Circle {
    name: String,
    raduis: f32,
}

impl Circle {
    /// Initialize new shape instance using default
    /// implementation of get_input() from shape_ops::Ops trait.
    pub fn new() -> Self {
        Self {
            name: String::from("Circle"),
            raduis: Self::get_input("Radius"),
        }
    }
}

/// Implementation of shape operation trait.
impl Ops for Circle {
    /// Calculates area of a Circle shape.
    /// Formula: PI * raduis * raduis.
    /// Return: suarface area of a shape as float.
    fn calculate_area(&self) -> f32 {
        PI * f32::powf(self.raduis, 2.0)
    }

    /// Display calculated area, volume, and other shape properties.
    fn print(&self) -> String {
        format!(
            "| {name:15} | {area:>10.2} | {volume:>10.2} | {props:>25} |",
            name = self.name,
            area = self.calculate_area(),
            volume = "",
            props = format_args!("{} r", self.raduis)
        )
    }
}
