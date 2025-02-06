#pragma once

#include "led.hpp"

/// @defgroup l496disco l496disco
/// @ingroup discovery
/// @brief `cpu:` @ref stm32l496agi
/// @{

extern LED LD2;  ///< `PB13` green / active high
extern LED LD3;  ///< `PA5`  green / active low

extern void blink();  ///< toggle @ref LD2

/// @}
