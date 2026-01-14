# [[hw/arch/Cortex-M|Cortex-M]] System bus

- Также имеется дополнительная [[System bus|системная шина]], которая предоставляет доступ к области системного управления по адресам 
	- 0x20000000-0xDFFFFFFF и 
	- 0xE0100000-0xFFFFFFFF. 
- This is for instruction and vector fetches, data load/stores and debug accesses to system space. This is a 32-bit AHB-Lite bus.
