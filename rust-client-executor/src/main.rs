use rust_socketio::{Client, ClientBuilder, Payload};
use serde_json::json;
use std::thread;
use std::time::Duration;
use std::any::{Any, TypeId};
use serde_json::{Result, Value};
use std::process::Command;
use std::thread::sleep;
use key_map::{press_key, release_key};


mod settings;
mod key_map;

use settings::{Settings, CommandConfig};

fn main() {
    let settings = Settings::new().unwrap();
    println!("{:?}", settings);

    let error_callback = |payload: Payload, socket: Client| {
        println!("Execute error");
        let string_payload = match payload {
            Payload::Binary(bin_data) => panic!("Received binary data: {:?}", bin_data),
            Payload::String(string_data) => string_data,
        };
        println!("{:?}", string_payload);
        // serde_json::from_str(&string_data).unwrap()
    };

    let execute_function_callback = move |payload: Payload, socket: Client| {
        println!("Execute function");
        let json_payload: Value = match payload {
            Payload::Binary(bin_data) => panic!("Received binary data: {:?}", bin_data),
            Payload::String(string_data) => serde_json::from_str(&string_data).unwrap()
        };
        let key_name = json_payload["function"].as_str().unwrap();
        let mut found_key = false;
        for commands in settings.commands.iter() {
            for command in commands.iter() {
                if key_name == command.trigger {
                    found_key = true;
                    let commmand_name = command.command.clone().unwrap();
                    if command.args == None {
                        Command::new(commmand_name).spawn().unwrap();
                    } else {
                        let args = command.args.clone().unwrap();
                        Command::new(commmand_name).args(args).spawn().unwrap();
                    }
                    break;
                }
            }
        }
        if !found_key {
            for mapping in settings.mappings.iter() {
                if key_name == mapping.trigger {
                    for keys in mapping.mapping.iter() {
                        for key in keys.iter() {
                            println!("{:?} press", key);
                            sleep(Duration::from_millis(50));
                            inputbot::KeybdKey::SpaceKey.release();
                            press_key(key.clone());
                        }
                        sleep(Duration::from_millis(600));
                        for key in keys.iter() {
                            println!("{:?} release", key);
                            inputbot::KeybdKey::SpaceKey.release();
                            release_key(key.clone());
                        }
                    }
                }
            }
        }
    };


    let socket = ClientBuilder::new(&settings.server)
        .namespace("/")
        //.on("test", callback)
        .on("on_error", error_callback)
        .on("execute", execute_function_callback)
        //.on("error", |err, _| eprintln!("Error: {:#?}", err))
        .connect()
        .expect("Connection failed");
    ctrlc::set_handler(move || {
        println!("received Ctrl+C!");
        std::process::exit(1);
    })
        .expect("Error setting Ctrl-C handler");

    socket.emit("server_connect", json!({"phrase": &settings.phrase})).unwrap();

    thread::sleep(Duration::from_secs(10000000));
}
