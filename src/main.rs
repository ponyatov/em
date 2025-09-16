mod config;
mod vm;

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
        eprintln!("\tsize: {} bytes", src.len());
        // eprintln!("{:?}", &mmap[..] as &str);
        io::stdout().write_all(&src[..]).unwrap();
    }
    vm::VM::new().run();
    gui::GUI::new(&argv[0]).run();
}

fn arg(argc: usize, argv: &str) {
    eprintln!("argv[{argc}] = {argv:?}");
}
