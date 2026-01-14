# SCB

`Drivers/[[CMSIS]]/Include/core_cm4.h`

```c
#define SCB ((SCB_Type*) SCB_BASE ) /*!< SCB configuration struct */
```

## VTOR
![[VTOR]]

![[CPACR]]

## AIRCR
- [[PRIGROUP]]
![[NVIC_SetPriorityGrouping]]

## SHP
### System Handlers Priority
```c
__IOM uint8_t  SHP[12U]; /*!< Offset: 0x018 (R/W)  System Handlers Priority Registers (4-7, 8-11, 12-15) */
```

