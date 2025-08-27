GZ += /usr/src/newlib/$(NEWLIB_GZ)
/usr/src/newlib/$(NEWLIB_GZ):
	sudo apt install newlib-source

GZ += $(DISTR)/$(BINUTILS_GZ)
$(DISTR)/$(BINUTILS_GZ):
	$(CURL) $@ $(BINUTILS_URL)/$(BINUTILS_GZ)

GZ += $(DISTR)/$(GCC_GZ)
$(DISTR)/$(GCC_GZ):
	$(CURL) $@ $(GCC_URL)/$(GCC_GZ)

GZ += static/cdn/jquery.min.js
static/cdn/jquery.min.js:
	$(CURL) $@ https://code.jquery.com/jquery-$(JQUERY_VER).min.js

GMP           = gmp-$(GMP_VER)
GMP_GZ        = $(GMP).tar.xz
GMP_URL       = https://ftp.gnu.org/gnu/gmp
GZ           += $(DISTR)/$(GMP_GZ)
$(DISTR)/$(GMP_GZ):
	$(CURL) $@ $(GMP_URL)/$(GMP_GZ)

MPFR          = mpfr-$(MPFR_VER)
MPFR_GZ       = $(MPFR).tar.xz
MPFR_URL      = https://www.mpfr.org/mpfr-current
GZ           += $(DISTR)/$(MPFR_GZ)
$(DISTR)/$(MPFR_GZ):
	$(CURL) $@ $(MPFR_URL)/$(MPFR_GZ)

MPC           = mpc-$(MPC_VER)
MPC_GZ        = $(MPC).tar.gz
MPC_URL       = https://ftp.gnu.org/gnu/mpc
GZ           += $(DISTR)/$(MPC_GZ)
$(DISTR)/$(MPC_GZ):
	$(CURL) $@ $(MPC_URL)/$(MPC_GZ)

LINUX         = linux-$(LINUX_VER)
LINUX_GZ      = $(LINUX).tar.xz
LINUX_URL     = https://cdn.kernel.org/pub/linux/kernel/v6.x
GZ           += $(DISTR)/$(LINUX_GZ)
$(DISTR)/$(LINUX_GZ):
	$(CURL) $@ $(LINUX_URL)/$(LINUX_GZ)

UCLIBC        = uClibc-ng-$(UCLIBC_VER)
UCLIBC_GZ     = $(UCLIBC).tar.xz
UCLIBC_URL    = https://downloads.uclibc-ng.org/releases/$(UCLIBC_VER)
GZ           += $(DISTR)/$(UCLIBC_GZ)
$(DISTR)/$(UCLIBC_GZ):
	$(CURL) $@ $(UCLIBC_URL)/$(UCLIBC_GZ)

BB            = busybox-$(BB_VER)
BB_GZ         = $(BB).tar.bz2
BB_URL        = https://busybox.net/downloads
GZ           += $(DISTR)/$(BB_GZ)
$(DISTR)/$(BB_GZ):
	$(CURL) $@ $(BB_URL)/$(BB_GZ)
