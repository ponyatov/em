RTARGET = x86_64-unknown-linux-gnu
# RTARGET = aarch64-unknown-linux-gnu
# RTARGET = wasm32-unknown-unknown
# RTARGET = thumbv7em-none-eabihf

$(RUSTUP) $(CARGO):
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	$(RUSTUP) component add rustfmt
	$(RUSTUP) target add $(RTARGET)
	$(RUSTUP) target add x86_64-unknown-linux-gnu
	$(RUSTUP) target add aarch64-unknown-linux-gnu
	$(RUSTUP) target add wasm32-unknown-unknown
	$(RUSTUP) target add thumbv7em-none-eabihf

# $(RUSTUP) component add rust-src --toolchain nightly

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
