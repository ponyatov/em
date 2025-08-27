/// @defgroup led led
/// @ingroup libhw
/// @brief generic LED control

#ifndef _LED_HPP_
#define _LED_HPP_

#include "pin.hpp"

/// @brief generic @ref LED control
class LED {};

extern void blink();  ///< toggle @ref LED1

#endif  // _LED_HPP_
