$(BIN)/$(BINFILE): $(C) $(H) $(MK) $(CM)
	cmake --fresh --preset glibc
	cmake --build --preset glibc -j

$(BIN)/$(BINFILE).exe: $(C) $(H) $(MK) $(CM)
	cmake --fresh --preset mingw
	cmake --build --preset mingw -j

.PHONY: $(ELF)
$(ELF): $(C) $(H) $(MK) $(CM)
	cmake --fresh --preset ${HW}
	cmake --build --preset ${HW} -j
