#include "usbd_cdc_if.h"

// https://community.st.com/t5/stm32-mcus/how-to-redirect-the-printf-function-to-a-uart-for-debug-messages/ta-p/49865
// https://community.st.com/t5/stm32-mcus-embedded-software/when-is-hal-usb-ready-for-me-to-send/td-p/240978

int __io_putchar(int ch) {
    /* Place your implementation of fputc here */
    /* e.g. write a character to the USART1 and Loop until the end of
     * transmission */
    // HAL_UART_Transmit(&huart2, (uint8_t *)&ch, 1, 0xFFFF);
    // CDC_TX_put(ch);
    while (CDC_Transmit_HS((uint8_t *)&ch, 1) != USBD_OK)
        HAL_Delay(11);  // blocking send
    return ch;
}
