use crate::Ops;
use std::f32::consts::PI;

/// Implementation for Cylinder shape.
pub struct Cylinder {
    name: String,
    radius: f32,
    height: f32,
}

impl Cylinder {
    /// Initialize new shape instance using default
    /// implementation of get_input() from shape_ops::Ops trait.
    pub fn new() -> Self {
        Self {
            name: String::from("Cylinder"),
            radius: Self::get_input("Radius"),
            height: Self::get_input("Height"),
        }
    }
}

/// Implementation of shape operation trait.
impl Ops for Cylinder {
    /// Calculates area of a Cylinder shape.
    /// Formula: pi * 2.0 * radius * (radius + height)
    /// Return: suarface area of a shape as float.
    fn calculate_area(&self) -> f32 {
        PI * 2.0 * self.radius * (self.radius * self.height)
    }

    /// Calculates volume of a Cylinder shape.
    /// Formula: pi * height * radius^2
    /// Return: volume of a shape as float.
    fn calculate_volume(&self) -> f32 {
        PI * self.height * f32::sqrt(self.radius)
    }

    /// Display calculated area, volume, and other shape properties.
    fn print(&self) -> String {
        format!(
            "| {name:15} | {area:>10.2} | {volume:>10.2} | {props:>25} |",
            name = self.name,
            area = self.calculate_area(),
            volume = self.calculate_volume(),
            props = format_args!("{} r x {} h", self.radius, self.height)
        )
    }
}
