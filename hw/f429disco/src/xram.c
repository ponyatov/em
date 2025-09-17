#ifndef F429DISCO
#error F429DISCO
#endif  // F429DISCO

#include "xram.h"

#ifdef DATA_IN_ExtSDRAM

// https://en.radzio.dxp.pl/stm32f429idiscovery/sdram.html

#define TMRD(x) (x << 0)  /* Load Mode Register to Active */
#define TXSR(x) (x << 4)  /* Exit Self-refresh delay */
#define TRAS(x) (x << 8)  /* Self refresh time */
#define TRC(x) (x << 12)  /* Row cycle delay */
#define TWR(x) (x << 16)  /* Recovery delay */
#define TRP(x) (x << 20)  /* Row precharge delay */
#define TRCD(x) (x << 24) /* Row to column delay */

void radzio_SDRAM_init(void) {
    volatile uint32_t tmp;
    // Enable clock for FMC
    RCC->AHB3ENR |= RCC_AHB3ENR_FMCEN;
    // Initialization step 1
    FMC_Bank5_6->SDCR[0] =
        FMC_SDCR1_SDCLK_1 | FMC_SDCR1_RBURST | FMC_SDCR1_RPIPE_1;
    FMC_Bank5_6->SDCR[1] =
        FMC_SDCR1_NR_0 | FMC_SDCR1_MWID_0 | FMC_SDCR1_NB | FMC_SDCR1_CAS;
    // Initialization step 2
    FMC_Bank5_6->SDTR[0] = TRC(7) | TRP(2);
    FMC_Bank5_6->SDTR[1] = TMRD(2) | TXSR(7) | TRAS(4) | TWR(2) | TRCD(2);
    // Initialization step 3
    while (FMC_Bank5_6->SDSR & FMC_SDSR_BUSY)
        ;
    FMC_Bank5_6->SDCMR = 1 | FMC_SDCMR_CTB2 | (1 << 5);
    // Initialization step 4
    for (tmp = 0; tmp < 1000000; tmp++)
        ;
    // Initialization step 5
    while (FMC_Bank5_6->SDSR & FMC_SDSR_BUSY)
        ;
    FMC_Bank5_6->SDCMR = 2 | FMC_SDCMR_CTB2 | (1 << 5);
    // Initialization step 6
    while (FMC_Bank5_6->SDSR & FMC_SDSR_BUSY)
        ;
    FMC_Bank5_6->SDCMR = 3 | FMC_SDCMR_CTB2 | (4 << 5);
    // Initialization step 7
    while (FMC_Bank5_6->SDSR & FMC_SDSR_BUSY)
        ;
    FMC_Bank5_6->SDCMR = 4 | FMC_SDCMR_CTB2 | (1 << 5) | (0x231 << 9);
    // Initialization step 8
    while (FMC_Bank5_6->SDSR & FMC_SDSR_BUSY)
        ;
    FMC_Bank5_6->SDRTR |= (683 << 1);
    while (FMC_Bank5_6->SDSR & FMC_SDSR_BUSY)
        ;
}

static void speed_test() {
  // extern void *_sxram, _exram;
  static uint8_t *xram_array = (uint8_t *)SDRAM_DEVICE_ADDR;
  static const size_t xram_size = SDRAM_DEVICE_SIZE / 0x40 + 0x40;
  //
  uint32_t start = HAL_GetTick();
  //
  uint8_t fill;
  for (int i = 0, fill = 0; i < xram_size; i++, fill++) {
    xram_array[i] = fill;
    if (xram_array[i] != fill) Error_Handler();
  }
  for (int i = 0, fill = 0; i < xram_size; i++, fill++) {
    if (xram_array[i] != fill) {
      char msg[] = "\nspeed_test() xram test fault\n";
      HAL_UART_Transmit(&huart1, (uint8_t *)msg, sizeof(msg), HAL_MAX_DELAY);
      HAL_Delay(111);
      Error_Handler();
    }
  }
  //
  uint32_t end = HAL_GetTick();
  uint32_t time = end - start;
}

#endif  // DATA_IN_ExtSDRAM

