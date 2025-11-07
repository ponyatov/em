HW     ?= pc
# HW     ?= qemu386
# HW     ?= rpi3
# HW     ?= rpi4
# HW     ?= rpi5
# HW     ?= opi800
# HW ?= a7n8x
# HW ?= pillf030
# HW ?= pillf103
# HW ?= lm3s6
# HW ?= iskra
# HW ?= f4disco
# HW ?= f429disco
# HW ?= l496disco
# HW ?= esp8266
# HW ?= esp32

include   hw/$(HW)/$(HW).mk
include  cpu/$(CPU)/$(CPU).mk
include arch/$(ARCH)/$(ARCH).mk
include   os/$(OS)/$(OS).mk

ELF = bin/$(BINFILE).elf
DFU = bin/$(BINFILE).dfu

.PHONY: elf
elf: $(ELF)
	$(QEMU) $(QEMU_CFG) -gdb tcp::3333 -S -kernel $<

.PHONY: dfu
dfu: $(DFU)
$(DFU): $(ELF)
	~/elf2dfuse/bin/elf2dfuse $< $@

XPATH = PATH=$(CROSS)/$(TARGET)/bin:$(PATH)
CFG   = configure --prefix=$(CROSS)/$(TARGET)

.PHONY: cross
cross: $(CROSS)/.gitignore $(ROOT)/.gitignore binutils gcc0
$(CROSS)/.gitignore: bin/.gitignore
	mkdir -p $(dir $@) ; cp $< $@
$(ROOT)/.gitignore: bin/.gitignore
	mkdir -p $(dir $@) ; cp $< $@

TLD = $(CROSS)/$(TARGET)/bin/$(TARGET)-ld
TCC = $(CROSS)/$(TARGET)/bin/$(TARGET)-gcc

.PHONY: binutils

BINUTILS_CFG += --disable-nls --target=$(TARGET)
BINUTILS_CFG += --with-sysroot=$(ROOT) --with-native-system-header-dir=/include
BINUTILS_CFG += --enable-lto --disable-multilib

binutils: $(TLD)
$(TLD): $(CROSS)/src/$(BINUTILS)/README
	rm -rf $(TMP)/$(BINUTILS) ; mkdir $(TMP)/$(BINUTILS) ; cd $(TMP)/$(BINUTILS) ;\
	$(XPATH) $(dir $<)/$(CFG) $(BINUTILS_CFG) &&\
	$(MAKE) -j$(CORES) && $(MAKE) install-strip

.PHONY: gcc0

GCC0_CFG += $(BINUTILS_CFG) --enable-languages="c"
GCC0_CFG += --disable-threads --without-headers --with-newlib

gcc0: $(TCC)
$(TCC): $(CROSS)/src/$(GCC)/README
	rm -rf $(TMP)/$(GCC) ; mkdir $(TMP)/$(GCC) ; cd $(TMP)/$(GCC) ;\
	$(XPATH) $(dir $<)/$(CFG) $(GCC0_CFG)
	cd $(TMP)/$(GCC) ; $(XPATH) $(MAKE) -j$(CORES) all-gcc
	cd $(TMP)/$(GCC) ; $(XPATH) $(MAKE) install-gcc
# 	cd $(TMP)/$(GCC) ; $(XPATH) $(MAKE) all-target-libgcc
# 	cd $(TMP)/$(GCC) ; $(XPATH) $(MAKE) install-target-libgcc

.PHONY: linux
linux: $(CROSS)/src/$(LINUX)/README
	rm -f $(dir $<).config
	cd $(dir $<) ; $(XPATH) $(MAKE) \
		ARCH=$(ARCH) CROSS_COMPILE=$(TARGET)- allnoconfig
	cat os/linux/all.kernel                    >> $(dir $<).config
	cat   hw/$(HW)/$(HW).kernel                >> $(dir $<).config
	cat  cpu/$(CPU)/$(CPU).kernel              >> $(dir $<).config
	cat arch/$(ARCH)/$(ARCH).kernel            >> $(dir $<).config
	cat   os/linux/$(APP).kernel               >> $(dir $<).config
	echo 'CONFIG_LOCALVERSION="-$(APP)_$(HW)"' >> $(dir $<).config
	echo 'CONFIG_DEFAULT_HOSTNAME="$(APP)"'    >> $(dir $<).config
	cd $(dir $<) ; $(XPATH) $(MAKE) \
		ARCH=$(ARCH) CROSS_COMPILE=$(TARGET)- menuconfig
	cd $(dir $<) ; $(XPATH) $(MAKE) \
		ARCH=$(ARCH) CROSS_COMPILE=$(TARGET)- -j$(CORES) bzImage
	cp $(dir $<)/arch/$(ARCH)/boot/bzImage $(ROOT)/boot/bzImage
	cd $(dir $<) ; $(XPATH) $(MAKE) \
		ARCH=$(ARCH) CROSS_COMPILE=$(TARGET)- -j$(CORES) modules
	cd $(dir $<) ; $(XPATH) $(MAKE) INSTALL_MOD_PATH=$(ROOT)/lib \
		ARCH=$(ARCH) CROSS_COMPILE=$(TARGET)- modules_install
	cd $(dir $<) ; $(XPATH) $(MAKE) INSTALL_HDR_PATH=$(ROOT)/usr \
		ARCH=$(ARCH) CROSS_COMPILE=$(TARGET)- headers_install

.PHONY: uclibc

uclibc: $(CROSS)/src/$(UCLIBC)/README
	rm -f $(dir $<).config
	cd $(dir $<) ; $(XPATH) $(MAKE) \
		ARCH=$(ARCH) CROSS_COMPILE=$(TARGET)- allnoconfig
	cat  os/linux/all.uclibc            >> $(dir $<).config
	echo 'KERNEL_HEADERS="$(ROOT)/usr/include"' >> $(dir $<).config
	echo 'RUNTIME_PREFIX="$(ROOT)/lib/runtime"' >> $(dir $<).config
	echo 'DEVEL_PREFIX="$(ROOT)/lib/devel"' >> $(dir $<).config
	cd $(dir $<) ; $(XPATH) $(MAKE) \
		ARCH=$(ARCH) CROSS_COMPILE=$(TARGET)- menuconfig
	cd $(dir $<) ; $(XPATH) $(MAKE) \
		ARCH=$(ARCH) CROSS_COMPILE=$(TARGET)- -j$(CORES)

.PHONY: initrd $(ROOT)/boot/initrd.cpio
initrd: $(ROOT)/boot/initrd.cpio
$(ROOT)/boot/initrd.cpio:
	cd $(dir $@)/.. ;\
	find . | egrep -v './(isolinux|boot)' | cpio --quiet -H newc -o | gzip -9 -n > $@
