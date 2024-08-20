use crate::{
    Box, Circle, Cube, Cylinder, Ellipse, Ops, Rectangle, Sphere, Square, Tetrahedron, Triangle,
};

/// Shape repository.
pub enum Shape {
    Box(Box),
    Cube(Cube),
    Sphere(Sphere),
    Cylinder(Cylinder),
    Tetrahedron(Tetrahedron),
    Circle(Circle),
    Ellipse(Ellipse),
    Rectangle(Rectangle),
    Square(Square),
    Triangle(Triangle),
}

impl Shape {
    pub fn new(value: &i32) -> Self {
        match value {
            1 => Self::Rectangle(Rectangle::new()),
            2 => Self::Square(Square::new()),
            3 => Self::Box(Box::new()),
            4 => Self::Cube(Cube::new()),
            5 => Self::Ellipse(Ellipse::new()),
            6 => Self::Circle(Circle::new()),
            7 => Self::Cylinder(Cylinder::new()),
            8 => Self::Sphere(Sphere::new()),
            9 => Self::Triangle(Triangle::new()),
            10 => Self::Tetrahedron(Tetrahedron::new()),
            _ => unreachable!(),
        }
    }

    pub fn print(&self) {
        let content = match &self {
            Self::Box(shape) => shape.print(),
            Self::Cube(shape) => shape.print(),
            Self::Sphere(shape) => shape.print(),
            Self::Cylinder(shape) => shape.print(),
            Self::Tetrahedron(shape) => shape.print(),
            Self::Circle(shape) => shape.print(),
            Self::Ellipse(shape) => shape.print(),
            Self::Rectangle(shape) => shape.print(),
            Self::Square(shape) => shape.print(),
            Self::Triangle(shape) => shape.print(),
        };
        println!("{content}");
    }
}
