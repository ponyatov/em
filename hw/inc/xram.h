#pragma once

#include <stdint.h>

#define Xsz (1024 * 1024)
extern uint8_t X[Xsz];
extern void radzio_SDRAM_init(void);

#ifdef F429DISCO
#include "stm32f429i_discovery_sdram.h"
#include "stm32f4xx_hal.h"
#endif  // F429DISCO

#ifdef L496DISCO
#include "stm32l4xx_hal.h"
#endif  // L496DISCO
