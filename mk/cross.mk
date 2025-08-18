HW ?= pc
# HW ?= qemu386
# HW ?= a7n8x
# HW ?= rpi3
# HW ?= rpi4
# HW ?= rpi5
# HW ?= opi800
# HW ?= mega2560
# HW ?= lm3s6
# HW ?= pillf030
# HW ?= pillf103
# HW ?= f4disco
# HW ?= iskra
# HW ?= l496disco
# HW ?= f429disco
# HW ?= esp32

include   hw/$(HW)/$(HW).mk
include  cpu/$(CPU)/$(CPU).mk
include arch/$(ARCH)/$(ARCH).mk
include   os/$(OS)/$(OS).mk

.PHONY: qemu
qemu: bin/$(BINFILE).iso
	$(QEMU) $(QEMU_CFG) -boot d -cdrom $<

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
	$(QEMU) $(QEMU_CFG) -gdb tcp::3333 -S -kernel $<
