CPU       = atmega2560
QEMU      = qemu-system-avr
QEMU_CFG += -machine mega2560 -bios demo.elf -s -S
