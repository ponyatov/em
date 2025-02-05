.PHONY: openocd
openocd: $(CWD)/hw/$(HW)/openocd $(ELF)
	$@ -f $< -c "program $(ELF) verify reset"

.PHONY: gdb
gdb: $(CWD)/hw/$(HW)/gdbinit $(ELF)
	$@-multiarch -q -se $(ELF) -x $<
