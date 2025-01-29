include arch/cortexM.mk

CPUFLAGS += -mcpu=cortex-m3
CFLAGS   += -DPREFETCH_ENABLE=1
CFLAGS   += -DLSI_VALUE=40000
