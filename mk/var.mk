# var
MODULE  = $(notdir $(CURDIR))
REL     = $(shell git rev-parse --short=4    HEAD)
BRANCH  = $(shell git rev-parse --abbrev-ref HEAD)
NOW     = $(shell date +%y%m%d)
BINFILE = $(MODULE)_$(HW)_$(BRANCH)
ELF     = $(BIN)/$(BINFILE).elf
DFU     = $(BIN)/$(BINFILE).dfu

ifeq ($(OS),Windows_NT)
	HOST = $(shell uname -o)
	EXE  = .exe
else
	HOST = $(shell lsb_release -si)
	EXE  =
endif
