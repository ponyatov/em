$(BIN)/$(BINFILE): target/debug/$(MODULE)
	cp $< $@
target/debug/$(MODULE): $(R) Cargo.toml .cargo/config.toml
	cargo build

$(ELF): target/$(RTARGET)/debug/flang
target/$(RTARGET)/debug/flang: $(R) Cargo.toml .cargo/config.toml
	cargo build +

# $(BIN)/$(BINFILE): $(C) $(H) $(MK) $(CM)
# 	cmake --fresh --preset glibc
# 	cmake --build --preset glibc -j

# .PHONY: $(ELF)
# $(ELF): $(C) $(H) $(MK) $(CM)
# 	cmake --fresh --preset ${HW}
# 	cmake --build --preset ${HW} -j
