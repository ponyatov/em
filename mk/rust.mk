RTARGET = x86_64-unknown-linux-gnu
# RTARGET = aarch64-unknown-linux-gnu
# RTARGET = i686-pc-windows-gnu
# RTARGET = thumbv7em-none-eabihf
# RTARGET = thumbv7m-none-eabi
# RTARGET = wasm32-unknown-unknown
# RTARGET = aarch64-linux-android
# RTARGET = armv7-linux-androideabi

$(RUSTUP) $(CARGO):
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	rustup target add x86_64-unknown-linux-gnu
# rustup target add aarch64-unknown-linux-gnu
# rustup target add i686-pc-windows-gnu
# rustup target add thumbv7em-none-eabihf
# rustup target add thumbv7m-none-eabi
# rustup target add wasm32-unknown-unknown
# rustup target add aarch64-linux-android
# rustup target add armv7-linux-androideabi
	rustup component add rust-analyzer rustfmt rust-src
# rustup component add llvm-tools
	cargo install cargo-watch cargo-binutils
# curl --proto '=https' --tlsv1.2 -LsSf https://github.com/probe-rs/probe-rs/releases/latest/download/probe-rs-tools-installer.sh | sh
