use app::App;
use std::path::PathBuf;

fn main() {
    let mut app = App::new();
    if let Err(e) = app.load(PathBuf::from("src/static/media.txt")) {
        println!("{e}");
        return;
    }
    loop {
        println!("{PROMPT}");
        match app.ask() {
            Ok(0) => break,
            Ok(5) => app.search(),
            Ok(v) => app.display(v),
            Err(error) => println!("{error}"),
        }
    }
}

const PROMPT: &str = "\n1. List All Songs\n2. List All Books\n3. List All Movies\n4. List All Media\n5. Search All Media by Title\n\n0. Exit Program\n";

mod traits {
    pub trait Cypher: RotStr {
        fn decrypt(&self, content: &String) -> String {
            self.rotate(content)
        }
        fn encrypt(&self, content: &String) -> String {
            self.rotate(content)
        }
    }

    pub trait Search {
        fn search(&self, term: &String) -> bool;
        fn search_by_title(title: &String, term: &String) -> bool {
            title
                .to_ascii_lowercase()
                .contains(&term.trim().to_ascii_lowercase())
        }
    }

    pub trait Summary: ToString + Cypher {
        fn summary(&self) -> String;
        fn summary_impl(&self, summary: &String) -> String {
            format!("{}\n| {}", self.to_string(), self.decrypt(&summary))
        }
    }

    pub trait RotStr {
        fn rotate(&self, content: &String) -> String {
            content.chars().map(Self::rot_char).collect()
        }
        fn rot_char(c: char) -> char {
            match c {
                c if c.is_ascii_uppercase() => ((c as u8 - 65 + 13) % 26 + 65) as char,
                c if c.is_ascii_lowercase() => ((c as u8 - 97 + 13) % 26 + 97) as char,
                _ => c,
            }
        }
    }
}

mod media {
    use super::{book::Book, movie::Movie, song::Song, traits::Search};

    pub enum Media {
        Song(Song),
        Book(Book),
        Movie(Movie),
    }

    impl Media {
        pub fn new(record: &Vec<&str>, summary: String) -> Result<Self, String> {
            let Ok(year) = i32::from_str_radix(record[2], 10) else {
                return Err(format!("[ERROR]: Unable to parse year."));
            };
            let title = String::from(record[1]);
            let al_au_dr = String::from(record[3]);
            Ok(match record[0] {
                "SONG" => Self::Song(Song::new(year, title, al_au_dr, String::from(record[4]))),
                "BOOK" => Self::Book(Book::new(year, title, al_au_dr, summary)),
                "MOVIE" => Self::Movie(Movie::new(year, title, al_au_dr, summary)),
                value => return Err(format!("[ERROR]: Unknown symbol '{value}'.")),
            })
        }

        pub fn search(&self, term: &String) -> bool {
            match self {
                Self::Song(v) => v.search(term),
                Self::Book(v) => v.search(term),
                Self::Movie(v) => v.search(term),
            }
        }

        pub fn filter(&self, choice: i32) -> bool {
            match self {
                Self::Song(_) => choice == 1,
                Self::Book(_) => choice == 2,
                Self::Movie(_) => choice == 3,
            }
        }
    }

    #[cfg(test)]
    mod tests {
        use crate::{
            book::Book,
            media::Media,
            movie::Movie,
            song::Song,
            traits::{Cypher, RotStr},
        };

        #[test]
        fn test_media_filter() {
            let song = Song::new(0i32, String::from("A Song"), String::new(), String::new());
            let book = Book::new(0i32, String::from("A Book"), String::new(), String::new());
            let movie = Movie::new(0i32, String::from("A Movie"), String::new(), String::new());

            let result = Media::Song(song).filter(1);
            assert!(result, "[Testing filter]: Failed, song does not match.");

            let result = Media::Book(book).filter(2);
            assert!(result, "[Testing filter]: Failed, book does not match.");

            let result = Media::Movie(movie).filter(3);
            assert!(result, "[Testing filter]: Failed, movie does not match.");
        }

        #[test]
        fn test_media_search() {
            let song = Song::new(
                0i32,
                String::from("A long long soulful song..."),
                String::new(),
                String::new(),
            );
            let result = Media::Song(song).search(&String::from("SOUL"));
            assert!(result, "[Testing search]: Failed, song does not found.");

            let song = Song::new(
                0i32,
                String::from("A long long soulful song..."),
                String::new(),
                String::new(),
            );
            let result = Media::Song(song).search(&String::from("blah"));
            assert!(!result, "[Testing search]: Failed, song does found.");
        }

        #[test]
        fn test_rot_char() {
            let result = Book::rot_char('A');
            assert_eq!(
                result, 'N',
                "[Testing rot_char]: Failed, Expected: 'N', found: '{result}'"
            );

            let result = Book::rot_char(result);
            assert_eq!(
                result, 'A',
                "[Testing rot_char]: Failed, Expected: 'A', found: '{result}'"
            );

            let result = Book::rot_char('z');
            assert_eq!(
                result, 'm',
                "[Testing rot_char]: Failed, Expected: 'm', found: '{result}'"
            );

            let result = Book::rot_char('9');
            assert_eq!(
                result, '9',
                "[Testing rot_char]: Failed, Expected: '9', found: '{result}'"
            );
        }

        #[test]
        fn test_rotate() {
            let movie = Movie::new(0i32, String::from("A Movie"), String::new(), String::new());

            let content = String::from("Hello");
            let expected = String::from("Uryyb");

            let result = movie.rotate(&content);
            assert_eq!(
                result, expected,
                "[Testing rotate]: Failed, Expected: '{expected}', found: '{result}'"
            );

            let result = movie.rotate(&result);
            assert_eq!(
                result, content,
                "[Testing rotate]: Failed, Expected: '{content}', found: '{result}'"
            );
        }

        #[test]
        fn test_book() {
            let summary = String::from("Fnheba, gur Qnex Ybeq, unf tngurerq gb uvz nyy gur Evatf bs Cbjre rkprcg bar - gur Bar Evat gung ehyrf gurz nyy - juvpu unf snyyra vagb gur unaqf bs gur uboovg Ovyob Onttvaf. Lbhat Sebqb Onttvaf svaqf uvzfrys snprq jvgu na vzzrafr gnfx jura Ovyob ragehfgf gur Evat gb uvf pner. Sebqb zhfg znxr n crevybhf wbhearl npebff Zvqqyr-rnegu gb gur Penpxf bs Qbbz, gurer gb qrfgebl gur Evat naq sbvy gur Qnex Ybeq va uvf rivy checbfr.");
            let book = Book::new(0i32, String::new(), String::new(), String::new());
            let content = Cypher::decrypt(&book, &summary);
            let content = Cypher::decrypt(&book, &content);
            assert_eq!(
                content, summary,
                "[Testing rotate]: Failed, Expected: '{summary}', found: '{content}'"
            );
        }
    }
}

mod song {
    use super::traits::Search;

    pub struct Song {
        year: i32,
        title: String,
        album: String,
        artist: String,
    }

    impl Song {
        pub fn new(year: i32, title: String, album: String, artist: String) -> Self {
            Self {
                year,
                title,
                album,
                artist,
            }
        }
    }

    impl Search for Song {
        fn search(&self, term: &String) -> bool {
            Self::search_by_title(&self.title, term)
        }
    }

    impl ToString for Song {
        fn to_string(&self) -> String {
            format!(
                "[Song] Title: {} ({}), Album: {}, Artist: {}",
                self.title, self.year, self.album, self.artist
            )
        }
    }
}

mod book {
    use super::traits::{Cypher, RotStr, Search, Summary};

    pub struct Book {
        year: i32,
        title: String,
        author: String,
        summary: String,
    }

    impl Book {
        pub fn new(year: i32, title: String, author: String, summary: String) -> Self {
            Self {
                year,
                title,
                author,
                summary,
            }
        }
    }

    impl RotStr for Book {}

    impl Cypher for Book {}

    impl Search for Book {
        fn search(&self, term: &String) -> bool {
            Self::search_by_title(&self.title, term)
        }
    }

    impl Summary for Book {
        fn summary(&self) -> String {
            self.summary_impl(&self.summary)
        }
    }

    impl ToString for Book {
        fn to_string(&self) -> String {
            format!(
                "[Book] Title: {} ({}), Author: {}",
                self.title, self.year, self.author
            )
        }
    }
}

mod movie {
    use super::traits::{Cypher, RotStr, Search, Summary};

    pub struct Movie {
        year: i32,
        title: String,
        director: String,
        summary: String,
    }

    impl Movie {
        pub fn new(year: i32, title: String, director: String, summary: String) -> Self {
            Self {
                year,
                title,
                director,
                summary,
            }
        }
    }

    impl RotStr for Movie {}

    impl Cypher for Movie {}

    impl Search for Movie {
        fn search(&self, term: &String) -> bool {
            Self::search_by_title(&self.title, term)
        }
    }

    impl Summary for Movie {
        fn summary(&self) -> String {
            self.summary_impl(&self.summary)
        }
    }

    impl ToString for Movie {
        fn to_string(&self) -> String {
            format!(
                "[Movie] Title: {} ({}), Director: {}",
                self.title, self.year, self.director
            )
        }
    }
}

mod app {
    use super::media::Media;
    use super::traits::Summary;
    use std::{
        fs,
        io::{self, Read, Write},
        path::PathBuf,
    };

    pub struct App(pub Vec<Media>);

    impl App {
        pub fn new() -> Self {
            Self(Vec::new())
        }
    }

    impl App {
        pub fn search(&self) {
            print!("Enter search term: ");
            io::stdout().flush().ok();
            let mut input = String::new();
            if let Err(_) = io::stdin().read_line(&mut input) {
                return;
            }
            if input.is_empty() {
                return;
            }
            self.0
                .iter()
                .filter(|m| m.search(&input))
                .for_each(|m| self.print(m, true));
        }

        pub fn display(&self, choice: i32) {
            if choice == 4 {
                self.0.iter().for_each(|m| self.print(m, false));
            } else {
                self.0
                    .iter()
                    .filter(|m| m.filter(choice))
                    .for_each(|m| self.print(m, false));
            }
        }

        fn print(&self, media: &Media, summarize: bool) {
            let content = match media {
                Media::Song(song) => song.to_string(),
                Media::Book(book) if summarize => book.summary(),
                Media::Book(book) => book.to_string(),
                Media::Movie(movie) if summarize => movie.summary(),
                Media::Movie(movie) => movie.to_string(),
            };
            println!("{}", content);
        }
    }

    impl App {
        pub fn load(&mut self, path: PathBuf) -> Result<(), String> {
            let Ok(mut file) = fs::OpenOptions::new().read(true).open(path) else {
                return Err(format!("[ERROR]: Unable to open the file."));
            };
            let mut buff = String::new();
            let Ok(_) = file.read_to_string(&mut buff) else {
                return Err(format!("[ERROR]: Unable to read file data."));
            };
            let mut record = Vec::<&str>::new();
            let mut summary = String::new();
            let mut list = Vec::<Media>::new();

            for line in buff.lines().into_iter() {
                if line.starts_with("---") {
                    list.push(match Media::new(&record, summary.clone()) {
                        Ok(media) => media,
                        Err(error) => return Err(error),
                    });
                    summary.clear();
                } else {
                    if line.contains("|") {
                        record = line.split("|").collect();
                    } else {
                        summary.push_str(line);
                    }
                }
            }
            self.0 = list;
            Ok(())
        }

        pub fn ask(&self) -> Result<i32, String> {
            print!("Enter your choice: ");
            io::stdout().flush().ok();

            let mut input = String::with_capacity(1);
            let Ok(_) = io::stdin().read_line(&mut input) else {
                return Err(format!("[Error]: Invalid Input."));
            };
            let Ok(choice) = input.trim().parse::<i32>() else {
                return Err(format!("[INFO]: Enter a valid number."));
            };
            if 0 < choice && choice > 5 {
                return Err(format!("[INFO]: Enter value between 0 and 5."));
            }
            Ok(choice)
        }
    }
}
