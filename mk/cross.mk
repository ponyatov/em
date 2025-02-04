HW ?= pc
# HW ?= f4disco
# HW ?= iskra
# HW ?= l496disco
# HW ?= pillF103
# HW ?= pillF030
# HW ?= mega2560

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
