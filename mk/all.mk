.PHONY: all run
all: bin/$(BINFILE) $(S)
	cargo build
run: bin/$(BINFILE) $(S)
	$^
	cargo run -- $(S)

.PHONY: wasm
wasm: static/$(APP).wasm static/hello.wasm
