#include "usb.h"

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

// bool CDC_TX_ready() {  /// check USB Tx ready
//     USBD_CDC_HandleTypeDef* hcdc =
//         (USBD_CDC_HandleTypeDef*)hUsbDeviceHS.pClassData;
//     if (hcdc->TxState != 0)
//         return false;
//     else
//         return true;
//             USBD_CDC_SetTxBuffer(&hUsbDeviceHS, &CDC_TX[CDC_TX_t], 1);
//             USBD_CDC_TransmitPacket(&hUsbDeviceHS);
// }
