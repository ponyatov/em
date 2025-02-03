$(BIN)/$(BINFILE): $(C) $(H)
	cmake         --preset linux
	cmake --build --preset linux -j

.PHONY: $(ELF)
$(ELF): $(C) $(H)
	cmake         --preset ${HW}
	cmake --build --preset ${HW}
