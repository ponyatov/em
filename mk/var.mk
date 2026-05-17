APP     = $(notdir $(CURDIR))
REL     = $(shell git rev-parse --short=4    HEAD)
BRANCH  = $(shell git rev-parse --abbrev-ref HEAD)
NOW     = $(shell date +%y%m%d)
PEPS    = E26,E302,E305,E401,E402,E701,E702
HW     ?= pc
BINFILE = $(APP)_$(HW)_$(BRANCH)_$(NOW)
CORES   = $(shell grep processor /proc/cpuinfo| wc -l)
IP     ?= 127.0.0.1
PORT   ?= 12345
PROXY  ?= 10.110.1.12:8888

DEVUSER = $(USER)
DEVIP   = 10.110.1.101
ETHOUT  = ens1f0np0
ETHIN   = ens3f0np0

ifeq ($(OS),Windows_NT)
	WS  = $(shell uname -o)
	EXE = .exe
else
	WS  = $(shell lsb_release -si)
	EXE =
endif
