#pragma once

#include "types.hpp"

/// @defgroup vm vm
/// @ingroup cli
/// @brief Virtual Machine
/// @{

/// @name config
/// @{

#define Dsz 0x10
#define Rsz 0x100
#define Msz 0x1000

/// @}

/// @name memory
/// @{

extern i32 D[Dsz];   ///< data stack
extern u8 Dp;        ///< @ref D pointer
extern U32 R[Rsz];   ///< return stack
extern u16 Rp;       ///< @ref R pointer
extern byte M[Msz];  ///< main memory
extern u32 Cp;       ///< compiler pointer
extern u32 Ip;       ///< instruction pointer

/// @name vm operations
/// @{
extern void push(i32 n);  ///< `( -- n )`
extern i32 pop();         ///< `( n -- )`
/// @}

/// @}

/// @}
