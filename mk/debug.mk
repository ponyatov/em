
ELF = $(BIN)/$(BINFILE).elf

.PHONY: openocd
openocd: $(CWD)/hw/$(HW).openocd $(ELF)
	$@ -f $< -c "program $(ELF) verify reset"
