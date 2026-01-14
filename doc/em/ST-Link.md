# [[ST-Link]]
## programmer for [[STM32]] MCUs
### программатор-отладчик ST-Link

> [[DAPLink]]

[доработка китайца](https://habr.com/ru/articles/402927/)

- https://count-zero.ru/2022/debugger/
- https://github.com/Krakenw/Stlink-Bootloaders

![](https://count-zero.ru/img/2022/debug/debug-05.jpg)
![sch](https://count-zero.ru/img/2022/debug/debug-25.gif)

## sw

- [[OpenOCD]]
- [[probe-rs]]
- [[STM32 ST-LINK Utility]]
- [[stlink-tools]]
- [[stlink-gui]]

## 2

- idVendor=0483, idProduct=3748
![[ST-Link v2]]

## V2-B
+ UART (PA9,PA10) -> USB [[VCP]]
- [[STM32F429I-DISC1]]

### 2.1

- idVendor=0483, idProduct=374b
- https://devicehunt.com/view/type/usb/vendor/0483/device/374B
- [[STMicroelectronics]] / [[ST-Link]]/V2.1

## 3

## dmesg

### [[STM32F407G-DISC1]]


```
[ 9388.152846] usb 2-1.2: new full-speed USB device number 7 using ehci-pci
[ 9388.263575] usb 2-1.2: New USB device found, idVendor=0483, idProduct=374b, bcdDevice= 1.00
[ 9388.263594] usb 2-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[ 9388.263600] usb 2-1.2: Product: STM32 STLink
[ 9388.263604] usb 2-1.2: Manufacturer: STMicroelectronics
[ 9388.263608] usb 2-1.2: SerialNumber: 066FFF565277524867093226
[ 9388.316463] usb-storage 2-1.2:1.1: USB Mass Storage device detected
[ 9388.316614] scsi host6: usb-storage 2-1.2:1.1
[ 9388.894098] cdc_acm 2-1.2:1.2: ttyACM0: USB ACM device
[ 9388.894132] usbcore: registered new interface driver cdc_acm
[ 9388.894136] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
[ 9389.329856] scsi 6:0:0:0: Direct-Access     MBED     microcontroller  1.0  PQ: 0 ANSI: 2
[ 9389.330526] sd 6:0:0:0: Attached scsi generic sg2 type 0
[ 9389.332181] sd 6:0:0:0: [sdc] 6216 512-byte logical blocks: (3.18 MB/3.04 MiB)
[ 9389.332906] sd 6:0:0:0: [sdc] Write Protect is off
[ 9389.332912] sd 6:0:0:0: [sdc] Mode Sense: 03 00 00 00
[ 9389.333537] sd 6:0:0:0: [sdc] No Caching mode page found
[ 9389.333546] sd 6:0:0:0: [sdc] Assuming drive cache: write through
[ 9389.353856] sd 6:0:0:0: [sdc] Attached SCSI removable disk
```
