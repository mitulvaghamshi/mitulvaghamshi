use self::{config::Config, grepper::Grepper};
use std::{env, process};

fn main() {
    let Ok(config) = Config::parse(env::args()) else {
        eprintln!("Problem parsing arguments");
        process::exit(1);
    };
    if let Err(e) = Grepper::run(&config) {
        eprintln!("[Mingrep Error]: {e}");
        process::exit(1);
    }
}

mod config {
    pub struct Config {
        pub query: String,
        pub path: String,
        pub ignore_case: bool,
    }

    impl Config {
        pub fn parse(mut args: impl Iterator<Item = String>) -> Result<Self, String> {
            args.next(); // skip (first arg) program name.
            let Some(query) = args.next() else {
                return Err(format!("Didn't get a query string"));
            };
            let Some(path) = args.next() else {
                return Err(format!("Didn't get a file path"));
            };
            Ok(Self {
                query,
                path,
                ignore_case: std::env::var("IGNORE_CASE").is_ok(),
            })
        }
    }
}

mod grepper {
    use super::config::Config;
    use std::{error::Error, fs};

    pub struct Grepper;

    impl Grepper {
        pub fn run(config: &Config) -> Result<(), Box<dyn Error>> {
            let content = fs::read_to_string(&config.path)?;
            let result = if config.ignore_case {
                Grepper::search(&config.query, &content)
            } else {
                Grepper::search_exact(&config.query, &content)
            };
            if result.len() <= 0 {
                println!("Could not found anything matching: {}", &config.query);
                return Ok(());
            }
            println!("Found {len} matches: ", len = result.len());
            result.into_iter().for_each(|line| println!("{line}"));
            Ok(())
        }

        fn search<'a>(query: &str, content: &'a str) -> Vec<&'a str> {
            let query = query.to_lowercase();
            content
                .lines()
                .filter(|line| line.to_lowercase().contains(&query))
                .collect()
        }

        fn search_exact<'a>(query: &str, content: &'a str) -> Vec<&'a str> {
            content
                .lines()
                .filter(|line| line.contains(query))
                .collect()
        }
    }

    #[cfg(test)]
    mod tests {
        use super::Grepper;

        #[test]
        fn test_search_case_sensitive() {
            let content = "Rust:\nsafe, fast, productive.\npick three.\nDuct tape.";
            let query = "duct";
            assert_eq!(
                vec!["safe, fast, productive."],
                Grepper::search_exact(query, content)
            );
        }

        #[test]
        fn test_search_case_insensitive() {
            let content = "Rust:\nsafe, fast, productive.\npick three.\nDuct tape.";
            let query = "DUcT";
            assert_eq!(
                vec!["safe, fast, productive.", "Duct tape."],
                Grepper::search(query, content)
            );
        }
    }
}
