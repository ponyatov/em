#pragma once

/// @defgroup sram sram
/// @brief BSP: external memory (PSRAM)
/// @ingroup stm32l496g
/// @{

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

/// @name status
/// @{
#define SRAM_OK 0x00
#define SRAM_ERROR 0x01
/// @}

/// @name config
/// @{

/// @brief bank address
#define SRAM_DEVICE_ADDR ((uint32_t)0x64000000)

/// @brief bank size, **Mbits**
#define SRAM_DEVICE_SIZE ((uint32_t)0x80000)

/// @brief data width mode
#define SRAM_MEMORY_WIDTH FMC_NORSRAM_MEM_BUS_WIDTH_16

/// @brief burst access mode
#define SRAM_BURSTACCESS FMC_BURST_ACCESS_MODE_DISABLE

/// @brief burst write mode
#define SRAM_WRITEBURST FMC_WRITE_BURST_DISABLE

/// @}

/// @name timings for IS66WV51216EBLL-70BLI
/// @brief clock at 80 MHz (period of 12.5 ns)
/// @{

/** @brief 60ns */
#define SRAM_ADDR_SETUP_TIME 5

/** @brief 30ns */
#define SRAM_DATA_SETUP_TIME 3

/** @brief 5ns */
#define SRAM_TURN_AROUND_TIME 1
/// @}

uint8_t BSP_SRAM_Init(void);
uint8_t BSP_SRAM_ReadData(uint32_t uwStartAddress, uint16_t *pData,
                          uint32_t uwDataSize);
uint8_t BSP_SRAM_ReadData_DMA(uint32_t uwStartAddress, uint16_t *pData,
                              uint32_t uwDataSize);
uint8_t BSP_SRAM_WriteData(uint32_t uwStartAddress, uint16_t *pData,
                           uint32_t uwDataSize);
uint8_t BSP_SRAM_WriteData_DMA(uint32_t uwStartAddress, uint16_t *pData,
                               uint32_t uwDataSize);
void BSP_SRAM_DMA_IRQHandler(void);

/// @}

#ifdef __cplusplus
}
#endif
