$(BIN)/$(BINFILE): $(C) $(H) $(MK) $(CM)
	cmake --fresh --preset linux
	cmake --build --preset linux -j

# .PHONY: $(ELF)
# $(ELF): $(C) $(H) $(MK) $(CM)
# 	cmake --fresh --preset ${HW}
# 	cmake --build --preset ${HW} -j
