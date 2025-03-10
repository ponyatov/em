OS     = bare
TARGET = arm-none-eabi
EXE    = .elf
APT   += gcc-$(TARGET)   gdb-multiarch
APT   += qemu-system-arm newlib-source
APT   += stlink-tools dfu-util dos2unix
