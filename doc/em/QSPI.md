# QSPI

F429 не умеет в quad с memory mapping, только [[STM32F446]]

https://vivonomicon.com/2020/08/08/bare-metal-stm32-programming-part-12-using-quad-spi-flash-memory/

- https://stackoverflow.com/questions/76944514/emulating-qspi-nor-flash-in-qemu

20 MHz Clock rate- SPI/SDI/SQI mode

- [[storage/SPIFFS]]
- [[FSMC]]

## modes

- Indirect [[#write]]
	- performs manual [[QSPI]] write transactions.
- Indirect [[#read]]
	- performs manual [[QSPI]] read transactions.
- Status flag polling
	- automatically reads a status register from the Flash chip until a specified set of flags are set and/or cleared
	- can be used to wait for long operations such as sector erases to complete.
- Memory-mapped I/O [[#romap]]
	- mounts the [[storage/Flash|Flash]] chip
		- **as read-only memory**
		- in the STM32’s internal memory space.
	- you’ll need to use the indirect read mode to read data which is located after the first 256MB.

## typical [[QSPI]] memory transaction

- [[#instruction]]
	- sends an 8-bit instruction to the chip
- [[#address]]
	- 24- default / 32-bit  > 16 Mb
- alternate bytes
- dummy
	- used to give the chip time to prepare its response
- data

## address

Most 8-pin Flash chips use 24-bit addressing by default, but since this one contains more than 16MB of memory, it also supports 32-bit addressing.

## instruction

`0x35` Enable Quad I/O
	use 4 data lines for every phase

## init
## read

![](https://vivonomicon.com/wp-content/uploads/2020/07/qspi_phases.png)

## write
## erase

- Flash memory can also only survive a limited number of erase cycles before it stops working
	- thats why peripheral’s “memory-mapped” mode cannot perform writes

## romap

