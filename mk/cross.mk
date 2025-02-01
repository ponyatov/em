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

BINFILE = $(MODULE)_$(HW)_$(BRANCH)_$(NOW)
ELF     = $(BIN)/$(BINFILE).elf
DFU     = $(BIN)/$(BINFILE).dfu

CC      = $(TARGET)-gcc
CXX     = $(TARGET)-g++
AS      = $(TARGET)-as
LD      = $(TARGET)-ld
SIZE    = $(TARGET)-size
OBJDUMP = $(TARGET)-objdump

.PHONY: elf
elf: $(ELF)

.PHONY: dfu
dfu: $(DFU)
$(DFU): $(ELF)
	~/elf2dfuse/bin/elf2dfuse $< $@
