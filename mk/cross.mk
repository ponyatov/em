# HW ?= pc
# HW ?= mega2560
# HW ?= pillF030
# HW ?= pillF103
# HW ?= f4disco
# HW ?= iskra
HW ?= l496disco

ELF     = $(BIN)/$(BINFILE).elf
DFU     = $(BIN)/$(BINFILE).dfu

include   hw/$(HW)/$(HW).mk
include  cpu/$(CPU)/$(CPU).mk
include arch/$(ARCH)/$(ARCH).mk
include   os/$(OS)/$(OS).mk

.PHONY: elf
elf: $(ELF)

.PHONY: dfu
dfu: $(DFU)
$(DFU): $(ELF)
	~/elf2dfuse/bin/elf2dfuse $< $@
