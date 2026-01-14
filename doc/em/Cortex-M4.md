# [[hw/arch/Cortex-M]]4
## [[ARMv7E-M]]
### [[thumb#2]] only

- [[Nordic]]
	- [[nRF52832]]
- [[STM32F4]]
	- [[STM32F405]] / [[STM32F407]]
	- [[STM32L496AG]]

##### 

- [[ARMv7E-M]] [[thumb#1]] + [[thumb#2]]
- 3-stage [[CPU#pipeline]] with branch speculation
- 32-bit hardware integer multiply 
	- with 32-bit or 64-bit result, 
	- signed or unsigned, 
	- [[asm/MAC]]: add or subtract after the multiply.
	- 32-bit Multiply and MAC are 1 cycle.
- 32-bit hardware integer divide (2–12 cycles)
- [[lang/saturation arithmetic]]
- DSP extension:
	- Single cycle 16/32-bit [[asm/MAC|MAC]], 
	- single cycle dual 16-bit MAC, 
	- 8/16-bit [[hw/SIMD|SIMD]] arithmetic.
- 12 cycle [[interrupt latency]]
- Integrated [[el/sleep]] modes
- Optional floating-point unit ([[FPU]])
	- [[FPv4-SP]] single precision only [[IEEE/754]] compliant
- Optional memory protection unit ([[MPU]])

![[em/Introduction|Introduction]]

![[hw/arch/TARGET#Cortex-M]]
