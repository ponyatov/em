let rsmain () =
  touch "src/main.rs"
    ~c:
      "mod config;\nmod vm;

use memmap2::Mmap;
use std::fs::File;
use std::io;
use std::io::Write;
use std::path::Path;

fn main() {
    let argv: Vec<String> = std::env::args().collect();
    let _argc = argv.len();
    arg(0, &argv[0]);
    for (argc, argv) in argv.iter().enumerate().skip(1) {
        arg(argc, argv);
        let file = File::open(Path::new(argv)).unwrap();
        let src = unsafe { Mmap::map(&file).unwrap() };
        eprintln!(\"\\tsize: {} bytes\", src.len());
        // eprintln!(\"{:?}\", &mmap[..] as &str);
        io::stdout().write_all(&src[..]).unwrap();
    }
}

fn arg(argc: usize, argv: &str) {
    eprintln!(\"argv[{argc}] = {argv:?}\");
}
"
    ()

let allow = "
#![allow(dead_code)]
#![allow(non_camel_case_types)]
#![allow(non_snake_case)]
#![allow(non_upper_case_globals)]
#![allow(unused_imports)]
"

let vmrs () =
  touch "src/vm.rs" ~c:(allow^"
use crate::config::vm::*;

/// main memory
pub static mut M: [u8; Msz] = [0; Msz];
pub static mut Cp: u16 = 0;
pub static mut Ip: u16 = 0;

/// return stack
pub static mut R: [u16; Rsz] = [0; Rsz];
pub static mut Rp: u8 = 0;

/// data stack
pub static mut D: [i32; Dsz] = [0; Dsz];
pub static mut Dp: u8 = 0;
") ()

let configrs () =
  touch "src/config.rs" ~c:("//! shared config\n"^allow^"
pub mod vm {
    /// @ref M size, bytes
    pub const Msz: usize = 0x10000;
    /// @ref R size, addresses
    pub const Rsz: usize = 0x100;
    /// @ef D size, cells
    pub const Dsz: usize = 0x10;
}
") ();

let cargo () =
  touch "Cargo.toml"
    ~c:
      ("[package]
name            =  \"" ^ app ^ "\"
version         =  \""
     ^ version ^ "\"
description     =  \"" ^ title ^ "\"
authors         = [\""
     ^ author ^ " <" ^ email ^ ">\"]
license         =  \"" ^ license
     ^ "\"
repository      =  \"" ^ github
     ^ "\"
edition         =  \"2024\"

[dependencies]
const_format    = \"0.2\"

[target.'cfg(target_os = \"linux\")'.dependencies]
libc            = \"0.2\"
memmap2         = \"0.9\"
"
      )
    ()

let rustmk () =
  touch "mk/all.mk"
    ~c:
      ".PHONY: all run watch
all:
\tcargo build
run:
\tcargo run -- lib/$(APP).ini
watch:
\tcargo watch -x 'run -- lib/$(APP).ini'
"
    ();
  touch "mk/rust.mk"
    ~c:
      "RTARGET = x86_64-unknown-linux-gnu

$(RUSTUP) $(CARGO):
\tcurl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
\trustup target add x86_64-unknown-linux-gnu
"
    ()

let rust () =
  rustmk ();
  rsmain ();
  cargo ();
  configrs (); vmrs();
  append ".gitignore" ~c:"/target/\n" ();
  Sys.command ("git add src");
  Sys.command ("cargo run -- lib/" ^ app ^ ".ini")
