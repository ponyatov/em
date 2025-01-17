#pragma once

/// @defgroup sram sram
/// @brief BSP: external memory (PSRAM)
/// @ingroup stm32l496g
/// @{

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

/// @}

/// @}
