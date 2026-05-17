#include "uart.h"

#include <string.h>

void UART_log(const char *msg) {
    HAL_UART_Transmit(&huart1, (uint8_t *)msg, strlen(msg), HAL_MAX_DELAY);
    while (!(HAL_UART_GetState(&huart1) & HAL_UART_STATE_READY))  //
        HAL_Delay(111);
}
