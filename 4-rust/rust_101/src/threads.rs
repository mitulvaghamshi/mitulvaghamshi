use std::sync::{mpsc, Arc, Mutex};
use std::thread;
use std::time::Duration;

/// Threads are all daemon threads, the main thread does not wait for them.
/// Thread panics are independent of each other.
/// Panics can carry a payload, which can be unpacked with `downcast_ref`.
pub fn simple_thread() {
    // Deamon thread
    let handle: thread::JoinHandle<()> = thread::spawn(|| {
        (1..10).for_each(|i| {
            println!("[Thread]: Deamon thread, Count: {i}");
            thread::sleep(Duration::from_millis(100));
        });
    });

    // Main thread
    (1..5).for_each(|i| {
        println!("[Main]: Thread, Count: {i}");
        thread::sleep(Duration::from_millis(100));
    });

    // Force main thread to wait until this thread finishes.
    handle.join().unwrap();
}

/// Moving environment data to the closure.
pub fn move_env_data() {
    let nums = vec![10, 20, 30];
    thread::spawn(move || println!("Vector: {nums:?}"));
}

/// Normal threads cannot borrow from their environment, use Scoped Thread.
/// The reason for that is that when the `thread::scope` function completes,
/// all the threads are guaranteed to be joined, so they can return borrowed data.
/// Normal Rust borrowing rules apply:
///     you can either borrow mutably by one thread,
///     or immutably by any number of threads.
pub fn scoped_thread() {
    let hello = String::from("Hello");
    thread::scope(|s| {
        s.spawn(|| println!("{}", hello.len()));
    });
}

/// Rust channels have two parts: a `Sender<T>` and a `Receiver<T>`.
/// The two parts are connected via the channel, but you only see the end-points.
/// `mpsc` stands for Multi-Producer, Single-Consumer.
/// `Sender` and `SyncSender` implement `Clone` (so you can make multiple producers) but `Receiver` does not.
/// `send()` and `recv()` return `Result`.
/// If they return `Err`, it means the counterpart `Sender` or `Receiver` is dropped and the channel is closed.
pub fn massage_passing() {
    let (tx, rx) = mpsc::channel::<String>();
    let chat_bot = thread::spawn(move || {
        thread::sleep(Duration::from_secs(1));
        tx.send(String::from("HELLO!")).expect("Unable to send!");
    });
    chat_bot.join().unwrap();
    let message = rx.try_recv().expect("Unable to get new message!");
    println!("Message received: {message}");
}

/// You get an unbounded and asynchronous channel with `mpsc::channel()`
pub fn unbounded_async_channel() {
    let (tx, rx) = mpsc::channel();
    thread::spawn(move || {
        let id = thread::current().id();
        (1..10).for_each(|i| {
            tx.send(format!("Message {i}")).unwrap();
            println!("{id:?}: sent Message {i}");
        });
        println!("{id:?}: done");
    });
    thread::sleep(Duration::from_millis(100));
    rx.iter().for_each(|msg| println!("Main: got {msg}"));
}

/// With bounded (synchronous) channels, send can block the current thread.
/// Calling send will block the current thread until there is space in the channel for the new message.
/// The thread can be blocked indefinitely if there is nobody who reads from the channel.
/// A call to send will abort with an error (that is why it returns Result) if the channel is closed.
/// A channel is closed when the receiver is dropped.
/// A bounded channel with a size of zero is called a “rendezvous channel”.
/// Every send will block the current thread until another thread calls read.
pub fn bounded_sync_channel() {
    let (tx, rx) = mpsc::sync_channel(3);
    thread::spawn(move || {
        let id = thread::current().id();
        (1..10).for_each(|i| {
            tx.send(format!("Message {i}")).unwrap();
            println!("{id:?}: sent Message {i}");
        });
        println!("{id:?}: done");
    });
    thread::sleep(Duration::from_millis(100));
    rx.iter().for_each(|msg| println!("Main: got {msg}"));
}

pub fn chat_bot() {
    let (client, server) = mpsc::channel::<i32>();

    let client_1 = client.clone();
    let sender_1: thread::JoinHandle<()> = thread::spawn(move || {
        (1..10).for_each(|i| {
            client_1.send(i).expect("[Sender 1]: Unable to send.");
            thread::sleep(Duration::from_millis(200));
        });
    });

    let client_2 = client.clone();
    let sender_2: thread::JoinHandle<()> = thread::spawn(move || {
        (11..20).for_each(|i| {
            client_2.send(i).expect("[Sender 2]: Unable to send.");
            thread::sleep(Duration::from_millis(100));
        });
    });

    drop(client);

    let receiver: thread::JoinHandle<()> = thread::spawn(move || {
        (1..20).for_each(|_| {
            if let Ok(message) = server.try_recv() {
                println!("Message received: {message}!");
            } else {
                println!("No new message!");
            }
            thread::sleep(Duration::from_millis(200));
        });
    });

    sender_1.join().unwrap();
    sender_2.join().unwrap();
    receiver.join().unwrap();
}

pub fn mutex_single_thread() {
    // Mutex is used to lock resources.
    let m = Mutex::new(0);

    // Blocks are introduced to narrow the scope of the LockGuard as much as possible.
    {
        let mut num = m.lock().expect("Unable to acquire a lock.");
        *num += 1;
    }
    println!("{m:?}");
}

/// `counter` is wrapped in both Arc and Mutex, because their concerns are orthogonal.
/// Wrapping a Mutex in an Arc is a common pattern to share mutable state between threads.
/// counter: Arc<_> needs to be cloned before it can be moved into another thread.
/// Note move was added to the lambda signature.
pub fn mutex_multi_thread() {
    let mut handlers = vec![];
    let counter = Arc::new(Mutex::new(0));

    (0..10).for_each(|_| {
        let counter = Arc::clone(&counter);
        handlers.push(thread::spawn(move || {
            let mut num = counter.lock().unwrap();
            *num += 1;
        }));
    });

    handlers
        .into_iter()
        .for_each(|handle| handle.join().unwrap());

    println!("Counter: {}", *counter.lock().unwrap());
}
