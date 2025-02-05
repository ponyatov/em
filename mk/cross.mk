HW ?= pc
# HW ?= f4disco
# HW ?= pillF103

include   hw/$(HW)/mk
include  cpu/$(CPU)/mk
include arch/$(ARCH)/mk
include   os/$(OS)/mk

.PHONY: elf
elf: $(ELF)

.PHONY: dfu
dfu: $(DFU)
$(DFU): $(ELF)
	~/elf2dfuse/bin/elf2dfuse $< $@
