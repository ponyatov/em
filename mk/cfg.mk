CFLAGS += -I$(INC) -I$(TMP) -O0 -ggdb -std=gnu++17

CFLAGS += -I$(CWD)/hw/$(HW)/inc
CFLAGS += -I$(CWD)/cpu/$(CPU)/inc
CFLAGS += -I$(CWD)/arch/$(ARCH)/inc
CFLAGS += -I$(CWD)/os/$(OS)/inc

CFLAGS += -I$(LIB)/cli/inc
CFLAGS += -I$(LIB)/core/inc
