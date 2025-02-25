.PHONY: openocd
openocd: $(CWD)/hw/$(HW)/$(HW).ocd $(ELF)
	$@ -f $< -c "program $(ELF) verify reset"

.PHONY: gdb
gdb: $(CWD)/hw/$(HW)/$(HW).gdb $(ELF)
	$@-multiarch -q -se $(ELF) -x $<
