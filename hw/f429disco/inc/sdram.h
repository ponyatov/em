#ifndef SDRAM_H_
#define SDRAM_H_

#include "stm32f4xx.h"
#include <memory.h>

#define TMRD(x) (x << 0)  /* Load Mode Register to Active */
#define TXSR(x) (x << 4)  /* Exit Self-refresh delay */
#define TRAS(x) (x << 8)  /* Self refresh time */
#define TRC(x) (x << 12)  /* Row cycle delay */
#define TWR(x) (x << 16)  /* Recovery delay */
#define TRP(x) (x << 20)  /* Row precharge delay */
#define TRCD(x) (x << 24) /* Row to column delay */

extern __attribute__((section(".xram"))) uint8_t _sixram, _sxram, _exram;

extern void SDRAM_Init();

#endif  // SDRAM_H_
