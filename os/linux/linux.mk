ifeq ($(ARCH),i386)
APT += linux-source gcc-12-source

GZ += ref/uclibc-$(UCLIBC_VER)/README
ref/uclibc-$(UCLIBC_VER)/README:
	cd ref ; apt source uclibc

GZ += ref/busybox-$(BB_VER)/README
ref/busybox-$(BB_VER)/README:
	cd ref ; apt source busybox

LINUX_MK = $(CWD)/ref/linux-$(LINUX_VER)/Makefile
GZ += $(LINUX_MK)
$(LINUX_MK):
	cd ref ; apt source linux
endif

LINUX_CFG += $(CWD)/hw/all.linux
LINUX_CFG += $(CWD)/arch/$(ARCH)/$(ARCH).linux
LINUX_CFG += $(CWD)/cpu/$(CPU)/$(CPU).linux
LINUX_CFG += $(CWD)/hw/$(HW)/$(HW).linux

LINUX_MAKE  = $(MAKE) -f $(LINUX_MK)
LINUX_MAKE += ARCH=$(ARCH) CROSS_COMPILE=$(LINUX_TARGET)-
LINUX_MAKE += INSTALL_PATH=$(BOOT)
LINUX_MAKE += INSTALL_MOD_PATH=$(ROOT)
LINUX_MAKE += INSTALL_HDR_PATH=$(ROOT)/usr
LINUX_MAKE += INSTALL_DTBS_PATH=$(ROOT)/dtbs

.PHONY: linux
linux: tmp/linux/.config $(LINUX_MK)
	cd tmp/kernel ;\
	$(LINUX_MAKE) menuconfig && $(LINUX_MAKE) -j2 &&\
	$(LINUX_MAKE) install modules_install headers_install &&\
	rm -f $(BOOT)/*.old
# dtbs_install

tmp/linux/.config: $(LINUX_CFG) mk/cross.mk os/linux/linux.mk
	mkdir -p $(dir $@) ; cd $(dir $@) ;\
	rm -f .config ; $(LINUX_MAKE) allnoconfig ;\
	cat $(LINUX_CFG) >> .config ;\
	echo 'CONFIG_LOCALVERSION="-$(HW)"'        >> .config ;\
	echo 'CONFIG_DEFAULT_HOSTNAME="$(MODULE)"' >> .config

UCLIBC_MK   = $(CWD)/tmp/uClibc-ng-$(UCLIBC_VER)/Makefile
UCLIBC_MAKE = $(MAKE) -f $(UCLIBC_MK) CROSS=$(TARGET)-
UCLIBC_CFG += $(CWD)/hw/all.uclibc
UCLIBC_CFG += $(CWD)/arch/$(ARCH)/$(ARCH).uclibc
UCLIBC_CFG += $(CWD)/cpu/$(CPU)/$(CPU).uclibc

.PHONY: uclibc
uclibc: $(UCLIBC_MK) $(UCLIBC_CFG) os/linux/linux.mk
	cd $(dir $<) ; rm .config ; $(UCLIBC_MAKE)    allnoconfig ;\
	cat $(UCLIBC_CFG)                              >> .config ;\
	echo 'KERNEL_HEADERS="$(ROOT)/usr/include"'    >> .config ;\
	echo 'RUNTIME_PREFIX="$(ROOT)"'                >> .config ;\
	echo 'DEVEL_PREFIX="$(ROOT)/usr"'              >> .config ;\
	echo 'CROSS_COMPILER_PREFIX="$(TARGET)-"'      >> .config ;\
	$(UCLIBC_MAKE) menuconfig &&\
	$(UCLIBC_MAKE) -j2 && $(UCLIBC_MAKE) install

GZ += /usr/src/linux-source-$(LINUX_VER)/Makefile
/usr/src/linux-source-$(LINUX_VER)/Makefile: /usr/src/linux-source-$(LINUX_VER).tar.xz
	cd /usr/src ; xzcat $< | sudo tar x && sudo touch $@
GZ += $(UCLIBC_MK)
$(UCLIBC_MK): /usr/src/uClibc-ng-$(UCLIBC_VER).tar.xz
	cd tmp ; xzcat $< | tar x && touch $@
