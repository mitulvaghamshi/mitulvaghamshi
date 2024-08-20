use std::path::PathBuf;
use structopt::StructOpt;

#[derive(Debug, StructOpt)]
pub enum Action {
    /// Write task to the database file.
    Add {
        /// The task description text.
        #[structopt()]
        content: String,
    },
    /// Remove an entry from the database file, by position.
    Done {
        #[structopt()]
        position: usize,
    },
    /// List all tasks in database file.
    List,
}

#[derive(Debug, StructOpt)]
#[structopt(name = "Todo App", about = "A command-line todo app written in Rust")]
pub struct CMDArgs {
    #[structopt(subcommand)]
    pub action: Action,
    /// Specify storage file path.
    #[structopt(parse(from_os_str), short, long)]
    pub file: Option<PathBuf>,
}
