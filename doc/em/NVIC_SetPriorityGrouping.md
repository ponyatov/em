# [[NVIC_SetPriority]]Grouping
## Set Priority Grouping

@ [[core_cm4]]

```c
__STATIC_INLINE void __NVIC_SetPriorityGrouping(uint32_t PriorityGroup)
{
  uint32_t reg_value;
  uint32_t PriorityGroupTmp = (PriorityGroup & (uint32_t)0x07UL);             /* only values 0..7 are used          */
```

- Sets the priority grouping field using the required unlock sequence
- the parameter `PriorityGroup` is assigned to the field SCB->AIRCR [10:8] [[PRIGROUP]] field.
	- [[SCB#AIRCR]]
		- [[SCB_AIRCR_VECTKEY_Msk]]
		- [[SCB_AIRCR_PRIGROUP_Msk]]
		- 0x5FAUL << [[SCB_AIRCR_VECTKEY_Pos]]
		- PriorityGroupTmp << [[SCB_AIRCR_PRIGROUP_Pos]]
- only values from 0..7 are used.
- [[__NVIC_PRIO_BITS]]

```c
  reg_value  =  SCB->AIRCR;                                                   /* read old register configuration    */
  reg_value &= ~((uint32_t)(SCB_AIRCR_VECTKEY_Msk | SCB_AIRCR_PRIGROUP_Msk)); /* clear bits to change               */
  reg_value  =  (reg_value                                   |
                ((uint32_t)0x5FAUL << SCB_AIRCR_VECTKEY_Pos) |
                (PriorityGroupTmp << SCB_AIRCR_PRIGROUP_Pos)  );              /* Insert write key and priority group */
  SCB->AIRCR =  reg_value;
}
```
- [[em/SCB#AIRCR]]
	- [[SCB_AIRCR_VECTKEY_Msk]]
	- [[SCB_AIRCR_PRIGROUP_Msk]]
- [[SCB_AIRCR_VECTKEY_Pos]]
- [[SCB_AIRCR_PRIGROUP_Pos]]

## [[NVIC_PRIORITYGROUP_4]]
- [[Cortex/MSI|MSI]] / [[SysTick]]

