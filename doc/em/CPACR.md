# [[SCB]] -> CPACR
### CoProcessor Access Control Register

```c
  __IOM uint32_t CPACR;                  /*!< Offset: 0x088 (R/W)  Coprocessor Access Control Register */
```

- [[SystemInit#FPU]]

Address offset (from SCB): 0x88
Reset value: 0x0000000
Required privilege: Privileged
The [[#CPACR]] register specifies the access privileges for coprocessors

![[CPACR.png]]

- Bits 31:24 Reserved. Read as Zero, Write Ignore.

- Bits 23:20 CPn: `[2n+1:2n]` for `n` values `10` and `11`. Access privileges for coprocessor `n`.

	- 0b00: Access denied. Any attempted access generates a NOCP [[UsageFault]].
	- 0b01: Privileged access only. An unprivileged access generates a [[NOCP]] fault.
	- 0b10: Reserved. The result of any access is Unpredictable.
	- 0b11: Full access.

- Bits 19:0 Reserved. Read as Zero, Write Ignore.
