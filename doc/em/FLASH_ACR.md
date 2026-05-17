# [[FLASH_ACR]]
## Flash Access Control Register
### [[FLASH_ACR_LATENCY_0WS]]

used to enable/disable the acceleration features and control the flash memory access time according to CPU frequency

Reset value: 0x0000 0000

![[FLASH_ACR.png]]

- Bit 12 [[DCRST]]: Data cache reset
- Bit 11 [[ICRST]]: Instruction cache reset
- Bit 10 [[DCEN]]: Data cache enable
- Bit 9 [[ICEN]]: Instruction cache enable
- Bit 8 [[PRFTEN]]: Prefetch enable

![[FLASH_ACR_LATENCY#FLASH_ACR]]
