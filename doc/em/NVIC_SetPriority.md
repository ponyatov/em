# NVIC_SetPriority
## [[NVIC_SetPriorityGrouping]]

Sets the priority of a device specific interrupt or a processor exception.

```c
#define NVIC_SetPriority            __NVIC_SetPriority
```
```c
__STATIC_INLINE void __NVIC_SetPriority(IRQn_Type IRQn, uint32_t priority)
```
- [[IRQn_Type]]
- [[__STATIC_INLINE]]
- [[SysTick_IRQn]]
- [[NVIC_EncodePriority]]
	- [[NVIC_GetPriorityGrouping]]
	- 