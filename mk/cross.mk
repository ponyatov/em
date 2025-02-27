# HW ?= pc
# HW ?= mega2560
# HW ?= pillF030
# HW ?= pillF103
# HW ?= f4disco
# HW ?= iskra
HW ?= l496disco
# HW ?= pi800

ELF     = $(BIN)/$(BINFILE).elf
DFU     = $(BIN)/$(BINFILE).dfu

include   hw/$(HW)/$(HW).mk
include  cpu/$(CPU)/$(CPU).mk
include arch/$(ARCH)/$(ARCH).mk
include   os/$(OS)/$(OS).mk

.PHONY: elf
elf: $(CWD)/hw/$(HW)/$(HW).ocd $(ELF)
	openocd -f $< -c "program $(ELF) verify reset exit"

.PHONY: dfu
dfu: $(DFU)
$(DFU): $(ELF)
	~/elf2dfuse/bin/elf2dfuse $< $@
