use futures_util::sink::SinkExt;
use futures_util::stream::StreamExt;
use std::error::Error;
use std::net::SocketAddr;
use tokio::net::{TcpListener, TcpStream};
use tokio::sync::broadcast::{channel, Sender};
use tokio_websockets::{Message, ServerBuilder, WebsocketStream};

async fn handle_connection(
    addr: SocketAddr,
    mut ws_stream: WebsocketStream<TcpStream>,
    bcast_tx: Sender<String>,
) -> Result<(), Box<dyn Error + Send + Sync>> {
    ws_stream
        .send(Message::text("Welcome to chat! Type a message".into()))
        .await?;

    let mut bcast_rx = bcast_tx.subscribe();

    // A continuous loop for concurrently performing two tasks: (1) receiving
    // messages from `ws_stream` and broadcasting them, and (2) receiving
    // messages on `bcast_rx` and sending them to the client.
    loop {
        tokio::select! {
            incoming = ws_stream.next() => {
                match incoming {
                    Some(Ok(msg)) => {
                        if let Some(text) = msg.as_text() {
                            println!("From client {addr:?} {text:?}");
                            bcast_tx.send(text.into())?;
                        }
                    }
                    Some(Err(err)) => return Err(err.into()),
                    None => return Ok(()),
                }
            }
            msg = bcast_rx.recv() => {
                ws_stream.send(Message::text(msg?)).await?;
            }
        }
    }
}

// Broadcast Chat Application
//
// In this exercise, we want to use our new knowledge to implement a broadcast chat application.
// We have a chat server that the clients connect to and publish their messages.
// The client reads user messages from the standard input, and sends them to the server.
// The chat server broadcasts each message that it receives to all the clients.
// For this, we use a broadcast channel on the server, and tokio_websockets for the communication between the client and the server.

// The required APIs
//
// You are going to need the following functions from tokio and tokio_websockets.
// Spend a few minutes to familiarize yourself with the API.
//
// StreamExt::next() implemented by WebsocketStream: for asynchronously reading messages from a Websocket Stream.
// SinkExt::send() implemented by WebsocketStream: for asynchronously sending messages on a Websocket Stream.
// Lines::next_line(): for asynchronously reading user messages from the standard input.
// Sender::subscribe(): for subscribing to a broadcast channel.

// Two binaries
//
// Normally in a Cargo project, you can have only one binary, and one src/main.rs file.
// In this project, we need two binaries.
// One for the client, and one for the server.
// You could potentially make them two separate Cargo projects,
// but we are going to put them in a single Cargo project with two binaries.

// Tasks
//
// Implement the handle_connection function in src/bin/server.rs.
// Hint:
// Use tokio::select! for concurrently performing two tasks in a continuous loop.
// One task receives messages from the client and broadcasts them.
// The other sends messages received by the server to the client.
//
// Complete the main function in src/bin/client.rs.
// Hint:
// As before, use tokio::select! in a continuous loop for concurrently performing two tasks:
// (1) reading user messages from standard input and sending them to the server, and
// (2) receiving messages from the server, and displaying them for the user.
//
// Optional:
// Once you are done, change the code to broadcast messages to all clients, but the sender of the message.
#[tokio::main]
async fn main() -> Result<(), Box<dyn Error + Send + Sync>> {
    let (bcast_tx, _) = channel(16);

    let listener = TcpListener::bind("127.0.0.1:2000").await?;
    println!("listening on port 2000");

    loop {
        let (socket, addr) = listener.accept().await?;
        println!("New connection from {addr:?}");
        let bcast_tx = bcast_tx.clone();
        tokio::spawn(async move {
            // Wrap the raw TCP stream into a websocket.
            let ws_stream = ServerBuilder::new().accept(socket).await?;

            handle_connection(addr, ws_stream, bcast_tx).await
        });
    }
}
