extern crate getopts;

use getopts::Options;
use std::{env, thread};
use std::fmt::format;
use std::time::Duration;
use rust_socketio::ClientBuilder;
use serde_json::json;
use inputbot::{KeybdKey::*, MouseButton::*, *};

fn main() {
    let args: Vec<String> = env::args().collect();
    // let program = args[0].clone();

    let mut opts = Options::new();
    opts.optopt("c", "code", "set connection-phrase", "phrase");
    opts.optflag("s", "server", "set the server (optional)");
    let matches = match opts.parse(&args[1..]) {
        Ok(m) => { m }
        Err(f) => { panic!("{}", f.to_string()) }
    };
    let server_address = match matches.opt_str("s") {
        Some(s) => { s }
        None => { "https://sd-replacement-server.mawoka.eu/".to_string() }
    };
    if !matches.opt_present("c") {
        panic!("No Phrase specified!");
    }
    let phrase = matches.opt_str("c").unwrap();

    println!("{} {}", server_address, phrase);

    let mut button_to_send = "";
    let socket = ClientBuilder::new(server_address)
        .namespace("/")
        //.on("test", callback)
        //.on("on_error", error_callback)
        // .on("execute", execute_function_callback)
        //.on("error", |err, _| eprintln!("Error: {:#?}", err))
        .connect()
        .expect("Connection failed");

    fn send_keypress() {}

    ctrlc::set_handler(move || {
        println!("received Ctrl+C!");
        std::process::exit(1);
    }).expect("Error setting Ctrl-C handler");
    inputbot::KeybdKey::bind_all(|evnt| {
        let event_str = format!("{:?}", &evnt);
        socket.emit("execute", json!({"function": event_str.replace("Key", "").to_string()})).expect("Failed to emit");
    });

    handle_input_events();
}
