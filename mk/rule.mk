# rule
$(BIN)/$(BINFILE): $(C) $(H)
	cmake         --preset linux
	cmake --build --preset linux -j

.PHONY: $(ELF)
$(ELF): $(C) $(H)
	cmake         --preset ${HW}
	cmake --build --preset ${HW}

# $(BIN)/$(BINFILE): $(C) $(H) $(CP) $(HP)
# 	$(CXX) $(CFLAGS) -o $@ $(C) $(CP) $(L)
# $(TMP)/%.lexer.cpp: $(SRC)/%.lex
# 	flex -o $@ $<
# $(TMP)/%.parser.cpp: $(SRC)/%.yacc
# 	bison -o $@ $<
