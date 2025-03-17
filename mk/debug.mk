.PHONY: ocd
ocd: $(CWD)/hw/$(HW)/$(HW).ocd
	openocd -f $<
# openocd -f $< -c "program $(ELF) verify reset"

.PHONY: gdb
gdb: $(CWD)/hw/$(HW)/$(HW).gdb $(ELF)
	gdb-multiarch -q -se $(ELF) -x $<

.PHONY: fw
fw: $(CWD)/hw/$(HW)/$(HW).ocd $(ELF)
	openocd -f $< -c "program $(ELF) verify reset exit"
