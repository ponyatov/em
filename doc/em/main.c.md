# main.c

## main

```c
int main(void) {
```
```c
/* Reset of all peripherals, Initializes the Flash interface and the Systick. */
LL_APB2_GRP1_EnableClock(LL_APB2_GRP1_PERIPH_SYSCFG);
LL_APB1_GRP1_EnableClock(LL_APB1_GRP1_PERIPH_PWR);
```
- [[LL_APB2_GRP1_EnableClock]]
	- [[LL_APB2_GRP1_PERIPH_SYSCFG]]
		- [[APB2ENR]]
- [[LL_APB1_GRP1_EnableClock]]
	- [[LL_APB1_GRP1_PERIPH_PWR]]

```c
/* System interrupt init*/
NVIC_SetPriorityGrouping(NVIC_PRIORITYGROUP_4);
```
- [[NVIC_SetPriorityGrouping]]
	- [[NVIC_PRIORITYGROUP_4]]
		- 0x111 = 0x07
- [[NVIC_SetPriority]]
	- [[NVIC_EncodePriority]]

- [[SystemClock_Config]]

[[GPIO#init]]
- MX_GPIO_Init