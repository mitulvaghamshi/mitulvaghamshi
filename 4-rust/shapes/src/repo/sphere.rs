use crate::Ops;
use std::f32::consts::PI;

/// Implementation for Sphere shape.
pub struct Sphere {
    name: String,
    radius: f32,
}

impl Sphere {
    /// Initialize new shape instance using default
    /// implementation of get_input() from shape_ops::Ops trait.
    pub fn new() -> Self {
        Self {
            name: String::from("Sphere"),
            radius: Self::get_input("Radius"),
        }
    }
}

/// Implementation of shape operation trait.
impl Ops for Sphere {
    /// Calculates area of a Sphere shape.
    /// Formula: pi * 4.0 * radius^2
    /// Return: suarface area of a shape as float.
    fn calculate_area(&self) -> f32 {
        PI * 4.0 * f32::sqrt(self.radius)
    }

    /// Calculates volume of a Sphere shape.
    /// Formula: 4/3 * pi * radius^3
    /// Return: volume of a shape as float.
    fn calculate_volume(&self) -> f32 {
        (4.0 / 3.0) * PI * f32::powf(self.radius, 3.0)
    }

    /// Display calculated area, volume, and other shape properties.
    fn print(&self) -> String {
        format!(
            "| {name:15} | {area:>10.2} | {volume:>10.2} | {props:>25} |",
            name = self.name,
            area = self.calculate_area(),
            volume = self.calculate_volume(),
            props = format_args!("{} r", self.radius)
        )
    }
}
