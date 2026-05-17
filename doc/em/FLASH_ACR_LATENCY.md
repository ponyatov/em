# [[FLASH_ACR]]_LATENCY

- http://forum.easyelectronics.ru/viewtopic.php?f=35&t=22805
- https://electronix.ru/forum/topic/169635-flash-latency-na-stm32f407/

это значение зависит от установленной системной частоты.
Чем она выше, тем больше настраивается циклов ожидания

референс-мануале RM0090

## [[FLASH_ACR]]

- [[STM32F407]]
	- Bits 2:0 `LATENCY[2:0]`: Latency
	- 0..7 [[wait state]]s (3 bits)
- [[STM32F429]]
	- `LATENCY[3:0]`
	- 0..15 (4 bits)

```c
#define FLASH_ACR_LATENCY_0WS          0x00000000U
#define FLASH_ACR_LATENCY_1WS          0x00000001U
#define FLASH_ACR_LATENCY_2WS          0x00000002U
#define FLASH_ACR_LATENCY_3WS          0x00000003U
#define FLASH_ACR_LATENCY_4WS          0x00000004U
#define FLASH_ACR_LATENCY_5WS          0x00000005U
#define FLASH_ACR_LATENCY_6WS          0x00000006U
#define FLASH_ACR_LATENCY_7WS          0x00000007U
```

