$(BIN)/$(BINFILE): $(C) $(H) $(MK) $(CM)
	cmake --fresh --preset glibc
	cmake --build --preset glibc -j

.PHONY: $(ELF)
$(ELF): $(C) $(H) $(MK) $(CM)
	cmake --fresh --preset ${HW}
	cmake --build --preset ${HW}
