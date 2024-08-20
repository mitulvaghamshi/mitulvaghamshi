mod cli;
mod file;
mod task;

use anyhow::{anyhow, Result};
use cli::{Action, CMDArgs};
use file::Database;
use std::path::PathBuf;
use structopt::StructOpt;

fn find_default_file() -> Option<PathBuf> {
    home::home_dir().map(|mut path| {
        path.push(".todo-data.json");
        path
    })
}

fn main() -> Result<()> {
    // Get the command line arguments.
    let CMDArgs { action, file } = CMDArgs::from_args();

    // Unpack the database file.
    let path = file
        .or_else(find_default_file)
        .ok_or(anyhow!("[ERROR]: Database file not found."))?;

    // Create database handle.
    let db = Database::new(path);

    // Handle user actions.
    match action {
        Action::Add { content } => db.add(content),
        Action::Done { position } => db.done(position),
        Action::List => db.list(),
    }?;
    Ok(())
}
