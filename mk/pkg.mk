NEWLIB       = newlib-$(NEWLIB_VER)
NEWLIB_GZ    = $(NEWLIB).tar.xz

YANDEX_MIRROR = https://mirror.yandex.ru/mirrors/gnu

GMP          = gmp-$(GMP_VER)
GMP_GZ       = $(GMP).tar.xz
GMP_URL      = $(YANDEX_MIRROR)/gmp

MPFR         = mpfr-$(MPFR_VER)
MPFR_GZ      = $(MPFR).tar.xz
MPFR_URL     = $(YANDEX_MIRROR)/mpfr

MPC          = mpc-$(MPC_VER)
MPC_GZ       = $(MPC).tar.gz
MPC_URL      = $(YANDEX_MIRROR)/mpc

BINUTILS     = binutils-$(BINUTILS_VER)
BINUTILS_GZ  = $(BINUTILS).tar.xz
BINUTILS_URL = $(YANDEX_MIRROR)/binutils

GCC          = gcc-$(GCC_VER)
GCC_GZ       = $(GCC).tar.xz
GCC_URL      = $(YANDEX_MIRROR)/gcc/$(GCC)

GDB          = gdb-$(GDB_VER)
GDB_GZ       = $(GDB).tar.xz
GDB_URL      = $(YANDEX_MIRROR)/gdb

LINUX        = linux-$(LINUX_VER)
LINUX_GZ     = $(LINUX).tar.xz
LINUX_URL    = https://cdn.kernel.org/pub/linux/kernel/v6.x

UCLIBC       = uClibc-ng-$(UCLIBC_VER)
UCLIBC_GZ    = $(UCLIBC).tar.xz
UCLIBC_URL   = https://downloads.uclibc-ng.org/releases/$(UCLIBC_VER)

BB           = busybox-$(BB_VER)
BB_GZ        = $(BB).tar.gz
BB_URL       = https://github.com/mirror/busybox/archive/refs/tags
