.PHONY: all run
all: $(BIN)/$(BINFILE) $(S)
	cargo build
run: $(BIN)/$(BINFILE) $(S)
	$^
	cargo run -- $(S)

.PHONY: wasm
wasm: static/$(APP).wasm static/hello.wasm
