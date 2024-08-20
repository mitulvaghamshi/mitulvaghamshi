// Derive a Copy trait for some structs, as in tests the methods sometimes don’t borrow their arguments.
// Discover that Add trait must be implemented for two objects to be addable via “+”.

use std::{f64::consts::PI, ops::Add};

#[derive(Debug, PartialEq, Clone, Copy)]
pub struct Point {
    x: f64,
    y: f64,
}

impl Point {
    // add methods
    fn new(x: i32, y: i32) -> Self {
        Self {
            x: x as f64,
            y: y as f64,
        }
    }

    fn magnitude(&self) -> f64 {
        // (x^2+y^2)^0.5
        (self.x.powf(2.0) + self.y.powf(2.0)).sqrt()
    }

    fn dist(&self, other: Self) -> f64 {
        // ((x2 - x1)^2 + (y2 - y1)^2)^0.5
        // (self - other).magnitude(); // impl PartalEq, Eq
        ((other.x - self.x).powf(2.0) + (other.y - self.y).powf(2.0)).sqrt()
    }
}

impl Add for Point {
    type Output = Self;
    fn add(self, rhs: Self) -> Self::Output {
        Point {
            x: self.x + rhs.x,
            y: self.y + rhs.y,
        }
    }
}

#[derive(Clone)]
pub struct Polygon {
    // add fields
    points: Vec<Point>,
}

impl Polygon {
    // add methods
    pub fn new() -> Self {
        Self { points: Vec::new() }
    }

    fn add_point(&mut self, point: Point) {
        self.points.push(point)
    }

    pub fn iter(&self) -> impl Iterator<Item = &Point> {
        self.points.iter()
    }

    fn left_most_point(&self) -> Option<Point> {
        // self.points.iter().min_by_key(|p| p.x).copied()
        let mut lmp = &self.points[0];
        for p in &self.points {
            if p.x < lmp.x {
                lmp = p;
            }
        }
        Some(lmp.clone())
    }
}

pub struct Circle {
    // add fields
    point: Point,
    radius: f64,
}

impl Circle {
    // add methods
    pub fn new(point: Point, radius: i32) -> Self {
        Self {
            point,
            radius: radius as f64,
        }
    }
}

pub enum Shape {
    Polygon(Polygon),
    Circle(Circle),
}

impl Shape {
    pub fn perimeter(&self) -> f64 {
        match self {
            Shape::Polygon(p) => {
                let mut iter = p.points.iter();
                let Some(mut from) = iter.next() else {
                    return 0.0;
                };
                let first = from;
                let mut sum = 0f64;
                for to in iter {
                    sum += from.dist(*to);
                    from = to;
                }
                sum += from.dist(*first);
                sum
            }
            Shape::Circle(c) => 2.0 * PI * c.radius,
        }
    }
}

impl From<Circle> for Shape {
    fn from(value: Circle) -> Self {
        Self::Circle(value)
    }
}

impl From<Polygon> for Shape {
    fn from(value: Polygon) -> Self {
        Self::Polygon(value)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn round_two_digits(x: f64) -> f64 {
        (x * 100.0).round() / 100.0
    }

    #[test]
    fn test_point_magnitude() {
        let p1 = Point::new(12, 13);
        assert_eq!(round_two_digits(p1.magnitude()), 17.69);
    }

    #[test]
    fn test_point_dist() {
        let p1 = Point::new(10, 10);
        let p2 = Point::new(14, 13);
        assert_eq!(round_two_digits(p1.dist(p2)), 5.00);
    }

    #[test]
    fn test_point_add() {
        let p1 = Point::new(16, 16);
        let p2 = p1 + Point::new(-4, 3);
        assert_eq!(p2, Point::new(12, 19));
    }

    #[test]
    fn test_polygon_left_most_point() {
        let p1 = Point::new(12, 13);
        let p2 = Point::new(16, 16);

        let mut poly = Polygon::new();
        poly.add_point(p1);
        poly.add_point(p2);
        assert_eq!(poly.left_most_point(), Some(p1));
    }

    #[test]
    fn test_polygon_iter() {
        let p1 = Point::new(12, 13);
        let p2 = Point::new(16, 16);

        let mut poly = Polygon::new();
        poly.add_point(p1);
        poly.add_point(p2);

        let points = poly.iter().cloned().collect::<Vec<_>>();
        assert_eq!(points, vec![Point::new(12, 13), Point::new(16, 16)]);
    }

    #[test]
    fn test_shape_perimeters() {
        let mut poly = Polygon::new();
        poly.add_point(Point::new(12, 13));
        poly.add_point(Point::new(17, 11));
        poly.add_point(Point::new(16, 16));
        let shapes = vec![
            Shape::from(poly),
            Shape::from(Circle::new(Point::new(10, 20), 5)),
        ];
        let perimeters = shapes
            .iter()
            .map(Shape::perimeter)
            .map(round_two_digits)
            .collect::<Vec<_>>();
        assert_eq!(perimeters, vec![15.48, 31.42]);
    }
}
