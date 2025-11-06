.PHONY: all run watch
all: bin/$(BINFILE) $(S)
	cargo build
run: bin/$(BINFILE) $(S)
	$^
	cargo run -- $(S)
watch: bin/$(BINFILE) $(S)
	@$^ ; while [ $$? -eq 1 ]; do $^ ; done

.PHONY: wasm
wasm: bin/$(APP).wasm
