# st-info
## Provides information about connected [[STLink]] and [[STM32/STM32|STM32]] devices

> [[st-util]]
> [[st-flash]]

Provides information about connected [[STLink]] programmers and [[STM32]] devices: Serial code, [[openocd]], flash, sram, page size, chipid, description.

### EXAMPLES

![[#--probe]]

## OPTIONS
##### `–version`
Print version information

##### `--flash`
Display amount of flash memory available in the device

##### `--sram`

Display amount of sram memory available in device

##### `--descr`
Display textual description of the device

##### `--pagesize`
Display the page size of the device

##### `--chipid`
Display the chip ID of the device

##### `--serial`
Display the serial code of the device

##### `--probe`

Display information about connected programmers and devices

```shell
$ st-info --probe
```

![[STM32F030F4P6#st-info]]
[[mcu/pillF030]]
