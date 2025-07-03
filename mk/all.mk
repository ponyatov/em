.PHONY: all run
all: $(BIN)/$(BINFILE) $(S)
run: $(BIN)/$(BINFILE) $(S)
	$^
