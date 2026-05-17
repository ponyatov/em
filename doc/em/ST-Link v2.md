# [[ST-Link#2]]

## китайский

- blue
```
[ 7486.170050] usb 2-4.2: new full-speed USB device number 11 using xhci_hcd
[ 7486.272650] usb 2-4.2: New USB device found, idVendor=0483, idProduct=3748, bcdDevice= 1.00
[ 7486.272663] usb 2-4.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[ 7486.272667] usb 2-4.2: Product: STM32 STLink
[ 7486.272670] usb 2-4.2: Manufacturer: STMicroelectronics
[ 7486.272673] usb 2-4.2: SerialNumber: !
```
- silver
```
[ 7643.614284] usb 2-4.2: new full-speed USB device number 12 using xhci_hcd
[ 7643.716732] usb 2-4.2: New USB device found, idVendor=0483, idProduct=3748, bcdDevice= 1.00
[ 7643.716746] usb 2-4.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[ 7643.716750] usb 2-4.2: Product: STM32 STLink
[ 7643.716753] usb 2-4.2: Manufacturer: STMicroelectronics
[ 7643.716756] usb 2-4.2: SerialNumber: Hÿk\x06H\xc2\x83SSH\x11 \xc2\x87
```

![[stlink2.png]]

![[st-info#`--probe`]]

- [[pillF103]]
```
2024-09-05T15:25:09 WARN usb.c: skipping ST device : 0x483:0x5715)
Found 1 stlink programmers
  version:    V2J37S7
  serial:     21003500072D343632525544
  flash:      65536 (pagesize: 1024)
  sram:       20480
  chipid:     0x0410
  descr:      F1xx Medium-density
```
- [[pillF030]]
```
2024-08-15T16:02:50 WARN usb.c: skipping ST device : 0x483:0x5715)
Found 1 stlink programmers
  version:    V2J17S4
  serial:     48FF6B064883535348110987
  flash:      16384 (pagesize: 1024)
  sram:       4096
  chipid:     0x0444
  descr:      F0xx small
```
[[STM32F030F4P6]]

- [[STM32F0DISCOVERY]]
- [[BluePill#st-info]]

![[serial_boot.jpg]]


### [[SWD]]

![[ST-Link_v2.png]]

[Доработка китайского ST-Link v2: добавляем интерфейс вывода отладочной информации SWO и ногу Reset](https://habr.com/ru/post/402927/)

## [[SWD]]
## [[JTAG#ARM JTAG 20-pin]]

## 1
ST-LINK/V2-1

## official ST-LINK/V2

The official ST-LINK/V2 is a debugger manufactured by ST Microelectronics and can be bought at any major electronics distributor. In addition to the standard ST-LINK/V2, ST offers a ST-LINK/V2-ISOL variant which features digital isolation between the PC and target board. This isolation withstands voltages up to 1000Vrms.

20-pin [[IDC#20]] connector:

![[STLINK2_IDC20.png]]

## [[Nucleo]]

The ST-LINK/V2 built into the [[Nucleo-64]] and [[Nucleo-144]] boards can also be used as stand-alone debugger. To use the built-in debugger, you must remove the jumpers from `CN2` (Nucleo-64) or `CN4` (Nucleo-144). Then you can use `CN4` (Nucleo-64) or `CN6` (Nucleo-144) to connect to your target board.

![[Nucleo_SWD.png]]

This debugger has a 6-pin dupont header for connecting to a SWD header on the target board. The pinout of this connector can be found below.

