GZ += /usr/src/newlib/$(NEWLIB_GZ)
/usr/src/newlib/$(NEWLIB_GZ):
	sudo apt install newlib-source

GZ += $(DISTR)/$(GMP_GZ)
$(DISTR)/$(GMP_GZ):
	$(CURL) $@ $(GMP_URL)/$(GMP_GZ)

GZ += $(DISTR)/$(MPFR_GZ)
$(DISTR)/$(MPFR_GZ):
	$(CURL) $@ $(MPFR_URL)/$(MPFR_GZ)

GZ += $(DISTR)/$(MPC_GZ)
$(DISTR)/$(MPC_GZ):
	$(CURL) $@ $(MPC_URL)/$(MPC_GZ)

GZ += $(DISTR)/$(BINUTILS_GZ)
$(DISTR)/$(BINUTILS_GZ):
	$(CURL) $@ $(BINUTILS_URL)/$(BINUTILS_GZ)

GZ += $(DISTR)/$(GCC_GZ)
$(DISTR)/$(GCC_GZ):
	$(CURL) $@ $(GCC_URL)/$(GCC_GZ)

GZ += $(DISTR)/$(GDB_GZ)
$(DISTR)/$(GDB_GZ):
	$(CURL) $@ $(GDB_URL)/$(GDB_GZ)

GZ += $(DISTR)/$(LINUX_GZ)
$(DISTR)/$(LINUX_GZ):
	$(CURL) $@ $(LINUX_URL)/$(LINUX_GZ)

GZ += $(DISTR)/$(UCLIBC_GZ)
$(DISTR)/$(UCLIBC_GZ):
	$(CURL) $@ $(UCLIBC_URL)/$(UCLIBC_GZ)

GZ += $(DISTR)/$(BB_GZ)
$(DISTR)/$(BB_GZ):
	$(CURL) $@ $(BB_URL)/$(BB_VER).tar.gz
