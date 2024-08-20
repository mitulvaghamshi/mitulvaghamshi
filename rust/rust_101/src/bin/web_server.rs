use self::{consts::HOST, response::handle_connection, tpool::ThreadPool};

type Job = Box<dyn FnOnce() + Send + 'static>;

fn main() {
    println!("Web Server Running at: http://{HOST}");

    // Listen for TCP connections on a socket.
    let listener = std::net::TcpListener::bind(HOST).unwrap();

    // Handle simultaneously upto 4 requests.
    let pool = ThreadPool::new(4);

    // Parse a small number of HTTP requests.
    for stream in listener.incoming().take(4) {
        println!("Connection established!");
        pool.execute(|| handle_connection(stream.unwrap()));
    }
    println!("Shutting down...");
}

/// Create a proper HTTP response.
mod response {
    use super::consts::{GET_DELAY, GET_INDEX, PATH_404, PATH_INDEX, STATUS_200, STATUS_404};
    use std::{fs, io::prelude::*, net::TcpStream, thread, time::Duration};

    pub fn handle_connection(mut stream: TcpStream) {
        let mut buffer = [0; 1024];
        stream.read(&mut buffer).unwrap();

        let (status, file) = if buffer.starts_with(GET_INDEX) {
            (STATUS_200, PATH_INDEX)
        } else if buffer.starts_with(GET_DELAY) {
            thread::sleep(Duration::from_secs(5));
            (STATUS_200, PATH_INDEX)
        } else {
            (STATUS_404, PATH_404)
        };

        let content = fs::read_to_string(format!("src/static/{file}")).unwrap();
        let response = format!(
            "{status}\r\nContent-Length: {len}\r\n\r\n{content}",
            len = content.len()
        );

        stream.write_all(response.as_bytes()).unwrap();
        stream.flush().unwrap();
    }
}

/// Individual request handler thread.
mod worker {
    use super::Job;
    use std::{
        sync::{mpsc, Arc, Mutex},
        thread,
    };

    pub struct Worker {
        pub id: usize,
        pub handle: Option<thread::JoinHandle<()>>,
    }

    impl Worker {
        pub fn new(id: usize, receiver: Arc<Mutex<mpsc::Receiver<Job>>>) -> Worker {
            let handle = thread::spawn(move || loop {
                match receiver.lock().unwrap().recv() {
                    Ok(job) => {
                        println!("Worker #{id} is ready...");
                        job();
                    }
                    Err(_) => {
                        println!("Worker #{id} is disconnected...");
                        break;
                    }
                }
            });
            Worker {
                id,
                handle: Some(handle),
            }
        }
    }
}

/// Improve the throughput of server with a thread pool.
mod tpool {
    use super::{worker::Worker, Job};
    use std::sync::{mpsc, Arc, Mutex};

    pub struct ThreadPool {
        workers: Vec<Worker>,
        sender: Option<mpsc::Sender<Job>>,
    }

    impl Drop for ThreadPool {
        fn drop(&mut self) {
            drop(self.sender.take());
            for worker in &mut self.workers {
                println!("Shutting down worker: {}", worker.id);
                if let Some(handle) = worker.handle.take() {
                    handle.join().unwrap();
                }
            }
        }
    }

    impl ThreadPool {
        /// Create a new ThreadPool
        /// The size is the number of Threads in the Pool.
        ///
        /// # Panics
        ///
        /// The `new` function will panic if the size is zero.
        ///
        /// # Tests
        ///
        /// ```rust,should_panic
        /// # use crate::examples::web_server::thread_pool::ThreadPool;
        ///
        /// let _ = ThreadPool::new(0);
        /// ```
        pub fn new(size: usize) -> ThreadPool {
            assert!(size > 0, "[ThreadPool]: The size cannot be zero.");

            let (tx, rx) = mpsc::channel();
            let receiver = Arc::new(Mutex::new(rx));
            let mut workers = Vec::with_capacity(size);

            (0..size).for_each(|id| {
                workers.push(Worker::new(id, Arc::clone(&receiver)));
            });

            ThreadPool {
                workers,
                sender: Some(tx),
            }
        }

        pub fn execute<F>(&self, f: F)
        where
            F: FnOnce() + Send + 'static,
        {
            self.sender.as_ref().unwrap().send(Box::new(f)).unwrap();
        }
    }
}

mod consts {
    pub const HOST: &str = "127.0.0.1:7878";

    pub const GET_INDEX: &[u8; 16] = b"GET / HTTP/1.1\r\n";
    pub const GET_DELAY: &[u8; 21] = b"GET /delay HTTP/1.1\r\n";

    pub const STATUS_200: &str = "HTTP/1.1 200 OK";
    pub const STATUS_404: &str = "HTTP/1.1 404 NOT FOUND";

    pub const PATH_INDEX: &str = "index.html";
    pub const PATH_404: &str = "404.html";
}
