HW ?= pc
# HW ?= qemu386
# HW ?= mega2560
# HW ?= lm3s6
# HW ?= pillF030
# HW ?= pillF103
# HW ?= f4disco
# HW ?= iskra
# HW ?= l496disco
# HW ?= f429disco
# HW ?= pi800
# HW ?= esp8266

include   hw/$(HW)/$(HW).mk
include  cpu/$(CPU)/$(CPU).mk
include arch/$(ARCH)/$(ARCH).mk
include   os/$(OS)/$(OS).mk

ifeq ($(ARCH),cortexM)

ELF = bin/$(BINFILE).elf
DFU = bin/$(BINFILE).dfu

.PHONY: elf
elf: $(ELF)

.PHONY: dfu
dfu: $(DFU)
$(DFU): $(ELF)
	~/elf2dfuse/bin/elf2dfuse $< $@

.PHONY: qemu
qemu: $(ELF)
	$(QEMU) $(QEMU_CFG) -gdb tcp::12345 -S -kernel $<

endif

ifeq ($(ARCH),i386)
.PHONY: qemu
qemu: bin/$(BINFILE).iso
	$(QEMU) $(QEMU_CFG) -gdb tcp::12345 -boot d -cdrom $<
endif
