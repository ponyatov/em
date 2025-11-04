.PHONY: all run watch
all: bin/$(BINFILE) $(S)
	cargo build
run: bin/$(BINFILE) $(S)
	$^
	cargo run -- $(S)
watch: bin/$(BINFILE) $(S)
<<<<<<< HEAD
	echo $^ | entr -r make run
=======
	@$^ ; while [ $$? -eq 1 ]; do $^ ; done
>>>>>>> d1c11ab8391ecb6c0dd0d8035a8f5ef79dc9ca58

.PHONY: wasm
wasm: static/$(APP).wasm static/hello.wasm
