RTARGET = x86_64-unknown-linux-gnu
# RTARGET = aarch64-unknown-linux-gnu
# RTARGET = wasm32-unknown-unknown
# RTARGET = thumbv7em-none-eabihf

$(RUSTUP) $(CARGO):
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	rustup target add x86_64-unknown-linux-gnu
	rustup target add wasm32-unknown-unknown
	rustup component add rustfmt
	cargo install cargo-watch
# rustup target add aarch64-unknown-linux-gnu
# rustup target add thumbv7em-none-eabihf
# rustup component add rust-src --toolchain nightly
# cargo install cargo-binutils
# rustup component add llvm-tools
# curl --proto '=https' --tlsv1.2 -LsSf https://github.com/probe-rs/probe-rs/releases/latest/download/probe-rs-tools-installer.sh | sh

$(BIN)/$(BINFILE): target/debug/$(MODULE)
target/debug/$(MODULE): $(R) Cargo.toml .cargo/config.toml
	cargo build

$(ELF): target/$(RTARGET)/debug/libfortex.d
	cp $< $@
target/$(RTARGET)/debug/libfortex.d: $(R) Cargo.toml .cargo/config.toml
	cargo build --target $(RTARGET) -p fortex
