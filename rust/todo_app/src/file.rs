use crate::task::Task;
use std::{
    fs::{File, OpenOptions},
    io::{Error, Result, Seek, SeekFrom, ErrorKind},
    path::PathBuf,
};

enum Flag {
    Read,
    Write,
    Create,
}

pub struct Database(PathBuf);

impl Database {
    /// Creates a new [`Database`].
    pub fn new(path: PathBuf) -> Self {
        Self(path)
    }

    pub fn add(&self, content: String) -> Result<()> {
        if content.is_empty() {
            return Err(Error::new(
                ErrorKind::InvalidData,
                "[INFO]: Cannot create an empty Todo.",
            ));
        }
        let file = self.open(Flag::Create)?;
        let mut tasks = self.read(&file)?;
        // Write the modified task list back to into the file.
        tasks.push(Task::new(content));
        self.write(&file, &tasks)?;
        Ok(())
    }

    pub fn done(&self, position: usize) -> Result<()> {
        let file = self.open(Flag::Write)?;
        let mut tasks = self.read(&file)?;
        if position == 0 || position > tasks.len() {
            return Err(Error::new(
                ErrorKind::InvalidInput,
                "[ERROR]: Invalid Todo ID",
            ));
        }
        // Remove the task at given position.
        tasks.remove(position - 1);
        // Write the modified task list back to into the file.
        file.set_len(0)?; // Truncate the file size.
        self.write(&file, &tasks)?;
        Ok(())
    }

    pub fn list(&self) -> Result<()> {
        let file = self.open(Flag::Read)?;
        let tasks = self.read(&file)?;
        if tasks.is_empty() {
            println!("[INFO]: Todo list is empty...!")
        } else {
            println!("--------------------------------------------------------------");
            println!(
                "| {:2} | {:<30} | {:>20} |",
                "ID", "Todo Item", "Date Created"
            );
            println!("--------------------------------------------------------------");
            for (i, task) in tasks.iter().enumerate() {
                println!("| {:2} | {} |", i + 1, task);
            }
            println!("--------------------------------------------------------------");
        }
        Ok(())
    }
}

impl Database {
    fn open(&self, flag: Flag) -> Result<File> {
        let mut options = OpenOptions::new();
        let options = match flag {
            Flag::Read => options.read(true),
            Flag::Write => options.read(true).write(true),
            Flag::Create => options.read(true).write(true).create(true),
        };
        options.open(&self.0)
    }

    fn read(&self, mut file: &File) -> Result<Vec<Task>> {
        file.seek(SeekFrom::Start(0))?; // Rewind the file.

        // Consume the file content as a Vector of Tasks.
        let tasks: Vec<Task> = match serde_json::from_reader(file) {
            Ok(tasks) => tasks,
            Err(error) if error.is_eof() => Vec::new(),
            Err(error) => Err(error)?,
        };

        file.seek(SeekFrom::Start(0))?; // Rewind the file.
        Ok(tasks)
    }

    fn write(&self, file: &File, tasks: &Vec<Task>) -> Result<()> {
        serde_json::to_writer(file, tasks)?;
        Ok(())
    }
}
