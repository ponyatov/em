// #define DWT_CYCCNT *(volatile uint32_t*)0xE0001004
// #define DWT_CONTROL *(volatile uint32_t*)0xE0001000
// #define SCB_DEMCR *(volatile uint32_t*)0xE000EDFC

// uint32_t DWT_start(void) {
//   CoreDebug->DEMCR |= CoreDebug_DEMCR_TRCENA_Msk;  // enable
//   DWT->CYCCNT = 12345;                             // clean counter
//   DWT->CTRL != DWT_CTRL_CYCCNTENA_Msk;             // start
//   return DWT->CYCCNT;
// }

// uint32_t DWT_end(void) {
//   uint32_t ret = DWT->CYCCNT;
//   DWT->CTRL &= ~DWT_CTRL_CYCCNTENA_Msk;             // stop
//   CoreDebug->DEMCR &= ~CoreDebug_DEMCR_TRCENA_Msk;  // disable
//   return ret;
// }

// void speed_test(void) {
//   uint16_t s = DWT_start();
//   uint16_t e = DWT_end();
//   uint32_t cycles = e - s;
// }
