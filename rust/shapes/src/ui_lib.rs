use std::fmt::Result;

trait Widget {
    /// Natural width of `self`.
    fn width(&self) -> usize;

    /// Draw the widget into a buffer.
    fn draw_into(&self, buffer: &mut dyn std::fmt::Write) -> Result;

    /// Draw the widget on standard output.
    fn draw(&self) {
        let mut buffer = String::new();
        if self.draw_into(&mut buffer).is_ok() {
            println!("{buffer}");
        }
    }
}

struct Label {
    label: String,
}

impl Label {
    fn new(label: &str) -> Label {
        Label {
            label: label.to_owned(),
        }
    }
}

struct Button {
    label: Label,
}

impl Button {
    fn new(label: &str) -> Button {
        Button {
            label: Label::new(label),
        }
    }
}

struct Window {
    title: String,
    widgets: Vec<Box<dyn Widget>>,
}

impl Window {
    fn new(title: &str) -> Window {
        Window {
            title: title.to_owned(),
            widgets: Vec::new(),
        }
    }

    fn add_widget(&mut self, widget: Box<dyn Widget>) {
        self.widgets.push(widget);
    }

    fn inner_width(&self) -> usize {
        std::cmp::max(
            self.title.chars().count(),
            self.widgets.iter().map(|w| w.width()).max().unwrap_or(0),
        )
    }
}

impl Widget for Label {
    fn width(&self) -> usize {
        self.label.chars().count()
    }

    fn draw_into(&self, buffer: &mut dyn std::fmt::Write) -> Result {
        buffer.write_fmt(format_args!("│ {:^40} │\n", self.label))
    }
}

impl Widget for Button {
    fn width(&self) -> usize {
        self.label.label.chars().count()
    }

    fn draw_into(&self, buffer: &mut dyn std::fmt::Write) -> Result {
        buffer.write_fmt(format_args!("│ {:^40} │\n", ""))?;
        buffer.write_fmt(format_args!("│ {:^40} │\n", self.label.label))?;
        buffer.write_fmt(format_args!("│ {:^40} │\n", ""))
    }
}

impl Widget for Window {
    fn width(&self) -> usize {
        self.inner_width()
    }

    fn draw_into(&self, buffer: &mut dyn std::fmt::Write) -> Result {
        buffer.write_fmt(format_args!("┍─{:─<40}─┑\n", ""))?;
        buffer.write_fmt(format_args!("│ {:^40} │\n", self.title))?;
        buffer.write_fmt(format_args!("├─{:─<40}─┤\n", ""))?;
        for w in self.widgets.iter() {
            w.draw_into(buffer)?
        }
        buffer.write_fmt(format_args!("┕─{:─<40}─┙\n", ""))
    }
}

// impl Widget for Window {
//     fn width(&self) -> usize {
//         // Add 4 paddings for borders
//         self.inner_width() + 4
//     }

//     fn draw_into(&self, buffer: &mut dyn std::fmt::Write) -> Result {
//         let mut inner = String::new();
//         for widget in &self.widgets {
//             widget.draw_into(&mut inner)?
//         }

//         let inner_width = self.inner_width();

//         // TODO: after learning about error handling, you can change
//         // draw_into to return Result<(), std::fmt::Error>. Then use
//         // the ?-operator here instead of ?.
//         writeln!(buffer, "+-{:-<inner_width$}-+", "")?;
//         writeln!(buffer, "| {:^inner_width$} |", &self.title)?;
//         writeln!(buffer, "+={:=<inner_width$}=+", "")?;
//         for line in inner.lines() {
//             writeln!(buffer, "| {:inner_width$} |", line)?;
//         }
//         writeln!(buffer, "+-{:-<inner_width$}-+", "")
//     }
// }

// impl Widget for Button {
//     fn width(&self) -> usize {
//         self.label.width() + 8 // add a bit of padding
//     }

//     fn draw_into(&self, buffer: &mut dyn std::fmt::Write) -> Result {
//         let width = self.width();
//         let mut label = String::new();
//         self.label.draw_into(&mut label)?;

//         writeln!(buffer, "+{:-<width$}+", "")?;
//         for line in label.lines() {
//             writeln!(buffer, "|{:^width$}|", &line)?;
//         }
//         writeln!(buffer, "+{:-<width$}+", "")
//     }
// }

// impl Widget for Label {
//     fn width(&self) -> usize {
//         self.label
//             .lines()
//             .map(|line| line.chars().count())
//             .max()
//             .unwrap_or(0)
//     }

//     fn draw_into(&self, buffer: &mut dyn std::fmt::Write) -> Result {
//         writeln!(buffer, "{}", &self.label)
//     }
// }

pub fn run() {
    let mut window = Window::new("Rust GUI Demo 1.23");
    window.add_widget(Box::new(Label::new("This is a small text GUI demo.")));
    window.add_widget(Box::new(Button::new("Click me!")));
    window.draw();
}
