.PHONY: all run watch
all: bin/$(BINFILE) $(S)
	cargo build
run: bin/$(BINFILE) $(S)
	$^
	cargo run -- $(S)
watch: bin/$(BINFILE) $(S)
	echo $^ | entr -r make run

.PHONY: wasm
wasm: static/$(APP).wasm static/hello.wasm
