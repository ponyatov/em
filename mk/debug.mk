# IP ?= 10.120.100.39
IP   ?= 127.0.0.1
PORT ?= 12345
.PHONY: gdbs gdb
gdbs: bin/$(BINFILE) $(S)
	gdbserver $(IP):$(PORT) $^
gdb: bin/$(BINFILE) $(S)
	gdb -nx -x .gdbinit $^

.PHONY: valg
valg: bin/$(BINFILE) $(S)
	valgrind $^ 2> tmp/$(APP).valgrind

.PHONY: ocd
ocd: $(CWD)/hw/$(HW)/$(HW).ocd
	openocd -f $<
# openocd -f $< -c "program $(ELF) verify reset"

.PHONY: gdb
gdb: $(CWD)/hw/$(HW)/$(HW).gdb $(ELF)
	gdb-multiarch -q -x $< -se $(ELF)

.PHONY: fw
fw: $(CWD)/hw/$(HW)/$(HW).ocd $(ELF)
	openocd -f $< -c "program $(ELF) verify reset exit"
