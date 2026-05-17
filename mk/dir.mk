CWD       = $(CURDIR)
BIN       = $(CWD)/bin
DOC       = $(CWD)/doc
LIB       = $(CWD)/lib
INC       = $(CWD)/inc
SRC       = $(CWD)/src
TMP       = $(CWD)/tmp
REF       = $(CWD)/ref
ETC       = $(CWD)/etc
DISTR    ?= $(HOME)/distr
#
CAR       = $(HOME)/.cargo
SWITCH   ?= default
CAML      = $(HOME)/.opam/$(SWITCH)
#
CROSS     = $(HOME)/cross
ROOT      = $(CWD)/root
BOOT      = $(ROOT)/boot
#
ESP       = $(HOME)/esp
IDF_PATH ?= $(ESP)/ESP8266_RTOS_SDK
