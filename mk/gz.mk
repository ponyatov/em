NEWLIB    = newlib-$(NEWLIB_VER)
NEWLIB_GZ = $(NEWLIB).tar.xz

GZ += /usr/src/newlib/$(NEWLIB_GZ)
/usr/src/newlib/$(NEWLIB_GZ):
	sudo apt install newlib-source

BINUTILS      = binutils-$(BINUTILS_VER)
BINUTILS_GZ   = $(BINUTILS).tar.xz
BINUTILS_URL  = https://sourceware.org/pub/binutils/releases
$(DISTR)/$(BINUTILS_GZ):
	$(CURL) $@ $(BINUTILS_URL)/$(BINUTILS_GZ)

GCC       = gcc-$(GCC_VER)
GCC_GZ    = $(GCC)-dfsg.tar.xz
GCC_URL   = https://mirror.yandex.ru/mirrors/gnu/gcc/$(GCC)

GZ += /usr/src/gcc-12/$(GCC_GZ)
/usr/src/gcc-12/$(GCC_GZ):
	sudo apt install gcc-12-source

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
