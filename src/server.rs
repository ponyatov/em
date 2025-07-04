use crate::config;

use std::{
    io::{Read, Write},
    net::{TcpListener, TcpStream},
    thread,
};

// HTTP return codes
const HTTP_200_OK: &[u8] = b"HTTP/1.1 200 OK\r\n";
const HTTP_404_NOTFOUND: &[u8] = b"HTTP/1.1 404 Not Found\r\n";

// MIME types
const TEXT_HTML: &[u8] = b"Content-Type: text/html\r\n";
const TEXT_PLAIN: &[u8] = b"Content-Type: text/plain\r\n";
const TEXT_CSS: &[u8] = b"Content-Type: text/css\r\n";
const IMAGE_PNG: &[u8] = b"Content-Type: image/png\r\n";

// static content
const INDEX_HTML: &[u8] = include_bytes!("../static/index.html");
const LOGO_PNG: &[u8] = include_bytes!("../doc/logo.png");
const CSS_CSS: &[u8] = include_bytes!("../static/css.css");
const JS_JS: &[u8] = include_bytes!("../static/js.js");

fn error_404(client: &mut TcpStream, method: &[u8], url: &[u8]) {
    client.write(&HTTP_404_NOTFOUND).unwrap();
    client.write(&TEXT_PLAIN).unwrap();
    client.write(b"\r\nmethod: ").unwrap();
    client.write(method).unwrap();
    client.write(b"\r\nurl: ").unwrap();
    client.write(url).unwrap();
}

fn index(client: &mut TcpStream) {
    client.write(&HTTP_200_OK).unwrap();
    client.write(&TEXT_HTML).unwrap();
    client.write(b"\r\n").unwrap();
    client.write(&INDEX_HTML).unwrap();
}

fn logo(client: &mut TcpStream) {
    client.write(&HTTP_200_OK).unwrap();
    client.write(&IMAGE_PNG).unwrap();
    client.write(b"\r\n").unwrap();
    client.write(&LOGO_PNG).unwrap();
}

fn css(client: &mut TcpStream) {
    client.write(&HTTP_200_OK).unwrap();
    client.write(&TEXT_CSS).unwrap();
    client.write(b"\r\n").unwrap();
    client.write(&CSS_CSS).unwrap();
}

fn js(client: &mut TcpStream) {
    client.write(&HTTP_200_OK).unwrap();
    client.write(&TEXT_HTML).unwrap();
    client.write(b"\r\n").unwrap();
    client.write(&JS_JS).unwrap();
}

fn router(mut client: TcpStream) {
    let mut buffer = [0; 1024];
    client.read(&mut buffer).unwrap();

    let request = buffer.split(|&x| x == b'\n').next().unwrap();
    eprintln!("{:?}", &request);
    let parts: Vec<&[u8]> = request.split(|&x| x == b' ').collect();
    let (method, url) = (parts[0], parts[1]);

    match (method, url) {
        (b"GET", b"/") | (b"GET", b"/index.html") => index(&mut client),
        (b"GET", b"/favicon.ico") | (b"GET", b"/logo.png") => logo(&mut client),
        (b"GET", b"/css.css") => css(&mut client),
        (b"GET", b"/js.js") => js(&mut client),
        _ => error_404(&mut client, method, url),
    }
    client.flush().unwrap();
}

pub fn run() {
    let listener = TcpListener::bind(config::BIND).unwrap();
    eprintln!("server @ http://{}:{}", config::IP, config::PORT);
    for client in listener.incoming() {
        match client {
            Ok(client) => {
                thread::spawn(|| router(client));
            }
            Err(e) => {
                eprintln!("Error: {}", e);
            }
        }
    }
}
