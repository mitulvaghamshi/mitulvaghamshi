use crate::Ops;

/// Implementation for Triangle shape.
pub struct Triangle {
    name: String,
    base: f32,
    height: f32,
}

impl Triangle {
    /// Initialize new shape instance using default
    /// implementation of get_input() from shape_ops::Ops trait.
    pub fn new() -> Self {
        Self {
            name: String::from("Triangle"),
            base: Self::get_input("Base"),
            height: Self::get_input("Height"),
        }
    }
}

/// Implementation of shape operation trait.
impl Ops for Triangle {
    /// Calculates area of a Triangle shape.
    /// Formula: 0.5 * base * height.
    /// Return: suarface area of a shape as float.
    fn calculate_area(&self) -> f32 {
        0.5 * self.base * self.height
    }

    /// Display calculated area, volume, and other shape properties.
    fn print(&self) -> String {
        format!(
            "| {name:15} | {area:>10.2} | {volume:>10.2} | {props:>25} |",
            name = self.name,
            area = self.calculate_area(),
            volume = "",
            props = format_args!("{} b x {} h", self.base, self.height)
        )
    }
}
