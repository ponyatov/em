/// @defgroup l496disco l496disco
/// @ingroup hw
/// @brief `cpu: ` @ref stm32l496ag

#ifndef _L496DISCO_HPP_
#define _L496DISCO_HPP_

#include "led.hpp"

/// @{

extern Pin PB13;
extern Pin PA5;

extern LED LD2(PB13);  ///< `PB13` green / active high
extern LED LD3(PA5);  ///< `PA5`  green / active low
#define LED1 LD2

/// @}

#endif  // _L496DISCO_HPP_
