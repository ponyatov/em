HW ?= pc
# HW ?= mega2560
# HW ?= pillF030
# HW ?= pillF103
# HW ?= iskra
# HW ?= f4disco
# HW ?= l496disco

include   hw/$(HW).mk
include  cpu/$(CPU).mk
include arch/$(ARCH).mk
include   os/$(OS).mk

.PHONY: elf
elf: $(ELF)

.PHONY: dfu
dfu: $(DFU)
$(DFU): $(ELF)
	~/elf2dfuse/bin/elf2dfuse $< $@
