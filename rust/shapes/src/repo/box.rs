use crate::Ops;

/// Implementation for Box shape.
pub struct Box {
    name: String,
    width: f32,
    height: f32,
    length: f32,
}

impl Box {
    /// Initialize new shape instance using default
    /// implementation of get_input() from shape_ops::Ops trait.
    pub fn new() -> Self {
        Self {
            name: String::from("Box"),
            length: Self::get_input("Length"),
            width: Self::get_input("Width"),
            height: Self::get_input("Height"),
        }
    }
}

/// Implementation of shape operation trait.
impl Ops for Box {
    /// Calculates area of a Box shape.
    /// Formula: (length * width + length * height + width * height) * 2.0
    /// Return: suarface area of a shape as float.
    fn calculate_area(&self) -> f32 {
        (self.length * self.width + self.length * self.height + self.width * self.height) * 2.0
    }

    /// Calculates volume of a Box shape.
    /// Formula: length * width * height
    /// Return: volume of a shape as float.
    fn calculate_volume(&self) -> f32 {
        self.length * self.width * self.height
    }

    /// Display calculated area, volume, and other shape properties.
    fn print(&self) -> String {
        format!(
            "| {name:15} | {area:>10.2} | {volume:>10.2} | {props:>25} |",
            name = self.name,
            area = self.calculate_area(),
            volume = self.calculate_volume(),
            props = format_args!("{} l x {} w x {} h", self.length, self.width, self.height)
        )
    }
}
