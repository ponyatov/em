#pragma once

#include "prim.hpp"

/// @defgroup int int
/// @ingroup prim
/// @{

class Int : public Prim {
   protected:
    int value;

   public:
    Int(int n);    ///< construct from integer
    Int(char* s);  ///< construct from string
};

/// @brief hexadecimal
class Hex : public Int {
   public:
    Hex(char* s);
};

/// @brief octal (file access bits)
class Oct : public Int {
   public:
    Oct(char* s);
};

/// @brief binary
class Bin : public Int {
   public:
    Bin(char* s);
};

/// @}
