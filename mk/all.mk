.PHONY: all run watch
all: bin/$(APP) $(S)
run: bin/$(APP) $(S)
	cgexec -g memory:$(APP) $^
	cargo run -- $(S)
watch:bin/$(APP) etc/config.json
	@until cgexec -g memory:$(APP) $^; [ $$? -ne 1 ]; do \
		echo "Restarting application..."; \
		sleep 0.1; \
	done
	cargo watch -x 'run -- $(S)'

.PHONY: wasm
wasm: bin/$(APP).wasm
