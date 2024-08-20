use std::{cmp::PartialEq, fmt::Display, ops::Sub};

fn main() {
    Node::fill(5).print(0);
}

pub enum Node<T> {
    Val {
        value: T,
        left: Box<Node<T>>,
        right: Box<Node<T>>,
    },
    Nil,
}

impl<T> Node<T>
where
    T: Copy + Display + PartialEq<i32> + Sub<i32, Output = T>,
{
    pub fn new(value: T) -> Box<Node<T>> {
        Box::new(Node::Val {
            value,
            left: Box::new(Node::Nil),
            right: Box::new(Node::Nil),
        })
    }

    fn fill(value: T) -> Node<T> {
        if value == 0 {
            Self::Nil
        } else {
            Self::Val {
                value,
                left: Box::new(Self::fill(value - 1)),
                right: Box::new(Self::fill(value - 1)),
            }
        }
    }

    fn print(&self, space: i32) {
        let Self::Val { value, left, right } = self else {
            return;
        };
        left.print(space + 1);
        (0..space).for_each(|_| print!("│  "));
        println!("├──{value}");
        right.print(space + 1);
    }
}
