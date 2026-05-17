//! shared config

#![allow(non_snake_case)]
#![allow(non_upper_case_globals)]
#![allow(dead_code)]

pub mod server {
    pub const ip: &str = "127.0.0.1";
    // pub const IP: &str = "0.0.0.0";
    pub const port: u16 = 12345;
    /// bind address constant
    pub const bind: &str = const_format::formatcp!("{ip}:{port}");
}

/// VM configuration parameters
pub mod vm {
    /// max VM memory size
    pub const Msz: usize = 0x10000;
    /// return stack size (max call depth)
    pub const Rsz: usize = 0x100;
    /// data stack size (limited for MCU use)
    pub const Dsz: usize = 0x10;
}

/// screen width
pub mod gui {
    /// screen width (mobile phone emulation)
    pub const width: i16 = 240;
    /// screen height (mobile phone emulation)
    pub const height: i16 = 320;
    /// large icons (for tiny phone screen)
    pub const icon_size: i16 = 64;
    /// base font size
    pub const font_size: i16 = icon_size / 2;

    /// root window background
    pub const root_bg: (u8, u8, u8) = (0x11, 0x22, 0x33);
    // status bar background
    pub const status_bg: (u8, u8, u8) = (0x11, 0x33, 0x22);
    // pub const status_clock: sdl2::pixels::Color = sdl2::pixels::Color::RGB(0xAA, 0xBB, 0xCC);
    // navigator bar background
    pub const navbar_bg: (u8, u8, u8) = (0x22, 0x22, 0x11);
}
