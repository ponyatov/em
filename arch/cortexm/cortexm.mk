OS      = none
TARGET  = arm-none-eabi
EXE    = .elf

GZ += /usr/src/newlib/$(NEWLIB_GZ)

APT    += qemu-system-arm gcc-arm-none-eabi gdb-multiarch
APT    += newlib-source openocd stlink-tools dfu-util dos2unix stm32flash
QEMU    = qemu-system-arm
