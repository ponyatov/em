.PHONY: openocd
openocd: $(CWD)/hw/$(HW)/$(HW).openocd
	$@ -f $< -c "program $(ELF) verify reset"

.PHONY: gdb
gdb: $(CWD)/hw/$(HW)/$(HW).gdbinit
	$@-multiarch -q -se $(ELF) -x $<
