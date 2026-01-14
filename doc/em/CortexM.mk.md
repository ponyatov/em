# arch/CortexM.mk

```Makefile
ARCH = CortexM
TRIPLET = arm-none-eabi
APT += stm32flash stlink-tools stlink-gui openocd gdb-multiarch gcc-$(TRIPLET)
```
- [[stm32flash]]
- [[stlink-tools]] [[stlink-gui]] [[openocd]] [[gdb-multiarch]]
##### build
```Makefile
.PHONY: build
build:
	$(MAKE) clean
	BOARD=$(BOARD) $(MAKE) all
```
##### probe
```Makefile
.PHONY: probe
probe:
	st-info --probe
```
