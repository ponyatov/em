#include "sdram.h"

/// https://en.radzio.dxp.pl/stm32f429idiscovery/sdram.html
void SDRAM_Init(void) {
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
    for (int tmp = 0; tmp < 1000000; tmp++)
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

    uint8_t* s = &_sxram;
    uint8_t* e = &_exram;
    size_t l = e - s;
    uint8_t* x = &_sixram;
    memcpy(s, x, l);
}
