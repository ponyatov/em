HW ?= pc
# HW ?= mega2560
# HW ?= stm32l496g

include   hw/$(HW).mk
include  cpu/$(CPU).mk
include arch/$(ARCH).mk
include   os/$(OS).mk

BINFILE = $(MODULE)_$(HW)_$(BRANCH)_$(NOW)

CC      = $(TARGET)-gcc
CXX     = $(TARGET)-g++
AS      = $(TARGET)-as
LD      = $(TARGET)-ld
SIZE    = $(TARGET)-size
OBJDUMP = $(TARGET)-objdump
