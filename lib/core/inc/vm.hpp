#pragma once

#include "object.hpp"

/// @defgroup vm vm
/// @brief Virtual Machine
/// @ingroup core
/// @{

/// @brief Virtual Machine
class VM : public Object {
   public:
    static void push(Object* o);  ///< `( -- o)` push @ref Object
    static Object* pop();         ///< `( o -- )` pop @ref Object
   private:
    /// @name config
    /// @{
    static const int Dsz = 0x10;    ///< @ref D size
    static const int Rsz = 0x100;   ///< @ref R size
    static const int Msz = 0x1000;  ///< @ref M size
    /// @}
    /// @name memory
    /// @{
    static Object* D[Dsz];  ///< data stack
    static u8 Dp;           ///< @ref D pointer
    static u16 R[Rsz];      ///< return stack (@ref Call/ @ref Ref)
    static u8 Rp;           ///< @ref R pointer
    static byte M[Msz];     ///< main memory
    static u16 Cp;          ///< @ref bc compiler pointer
    static u16 Ip;          ///< @ref bc interpreter pointer
    /// @}
};
/// @}
