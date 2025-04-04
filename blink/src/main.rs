#![no_std]
#![no_main]

use cortex_m_rt::entry;
use cortex_m_semihosting::{debug, hprintln};
use panic_halt as _;

#[entry]
fn main() -> ! {
    hprintln!("Hello, world!");
    debug::exit(debug::EXIT_SUCCESS); // Exit the program with success status
    loop {}
}
