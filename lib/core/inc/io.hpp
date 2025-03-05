/// @defgroup io io
/// @ingroup lib
/// @brief hardware i/o abstraction
/// @{

#pragma once

#include "object.hpp"

/// @brief generic i/o peripherial
class IO : public Object {};

/// @brief GPIO
class Pin : public IO {
    uint pin;

   public:
    Pin(uint pin);
};

/// @}
