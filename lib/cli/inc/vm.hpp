#pragma once

/// @defgroup vm vm
/// @ingroup cli
/// @brief tiny stack Virtual Machine
/// @{

#include "core.hpp"

/// @ref D size
#define Dsz 0x10

/// @brief data stack
extern Object* D[Dsz];
/// @ref D pointer
extern uint Dp;

extern void push(Object*);
extern Object* pop();

extern void nop();
extern void halt();

extern void dump();  //< `( -- )` dump @ref D

extern void dot();  //< `( ... -- )` clean @ref D

extern void dup();   ///< `( a -- a a )` duplicate
extern void drop();  ///< `( a -- )` remote top element
extern void swap();  ///< `( a b -- b a )`

/// @}
