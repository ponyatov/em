#pragma once

#include "types.hpp"

/// @defgroup vm vm
/// @ingroup cli
/// @brief Virtual Machine
/// @{

#include "stack.hpp"

#include "object.hpp"

/// @brief Virtual Memory abstraction
class VM : public Object {
    /// @name config
    /// @{
    static const uint Dsz = 0x10;    ///< @ref D size
    static const uint Rsz = 0x100;   ///< @ref R size
    static const uint Msz = 0x1000;  ///< @ref M size

    /// @}

   public:
    static const char name[];  ///< print @ref VM name as command line header
    VM();

    /// @name memory
    /// @{

    i32 D[Dsz];   ///< data stack
    u8 Dp;        ///< @ref D pointer
    u32 R[Rsz];   ///< return stack
    u16 Rp;       ///< @ref R pointer
    byte M[Msz];  ///< main memory
    u32 Cp;       ///< compiler pointer
    u32 Ip;       ///< instruction pointer

    /// @}

    /// @name vm operations
    /// @{
    void push(i32 n);  ///< `( -- n )`
    i32 pop();         ///< `( n -- )`
    /// @}
};

extern VM vm;  ///< global @ref VM

/// @}
