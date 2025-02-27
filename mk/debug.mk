.PHONY: ocd
ocd: $(CWD)/hw/$(HW)/$(HW).ocd
	openocd -f $<
# openocd -f $< -c "program $(ELF) verify reset"

.PHONY: gdb
gdb: $(CWD)/hw/$(HW)/$(HW).gdb $(ELF)
	gdb-multiarch -q -se $(ELF) -x $<
