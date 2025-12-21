<<<<<<< HEAD
let rust () =
  touch "src/main.rs" ~c:"mod config;\nmod vm;
=======
let rsmain () =
  touch "src/main.rs"
    ~c:
      "mod config;\nmod vm;
>>>>>>> ebc2351d16f8ac53c3e45a30e4e3ceef0045b36d

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
<<<<<<< HEAD
" ();
  touch "src/config.rs" ();
  touch "src/vm.rs" ();
  Sys.command "cargo run";
=======
"
    ();
  touch "src/config.rs" ();
  touch "src/vm.rs" ()
>>>>>>> ebc2351d16f8ac53c3e45a30e4e3ceef0045b36d

let cargo () =
  touch "Cargo.toml"
    ~c:
      ("[package]
<<<<<<< HEAD
name        =  \"" ^ app ^ "\"
version     =  \"" ^ version ^ "\"
description =  \"" ^ title ^ "\"
authors     = [\""^author^" <"^email^">\"]
license     =  \""^license^"\"
repository  =  \""^github^"\"
edition     =  \"2024\"

[dependencies]

[target.'cfg(target_os = \"linux\")'.dependencies]
libc        = \"0.2\"
memmap2     = \"0.9\"
")
    ();
  Sys.command ("cargo run -- lib/"^app^".ini")
=======
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
    ();
  Sys.command ("cargo run -- lib/" ^ app ^ ".ini")

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
  cargo ()
>>>>>>> ebc2351d16f8ac53c3e45a30e4e3ceef0045b36d
