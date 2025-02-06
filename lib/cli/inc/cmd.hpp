#pragma once

#include "os.hpp"

/// @defgroup cmd cmd
/// @ingroup vm
/// @brief @ref vm commands
/// @{

#include "object.hpp"

/// @brief @ref VM command
class Cmd : public Object {};

/// @name flow control
/// @{

extern void nop();   ///< `( -- )` empty command: do nothing
extern void halt();  ///< `( -- )` stop system

/// @}

/// @name stack ops
/// @{
extern void dup();   ///< `( n -- n n )`
extern void drop();  ///< `( n -- )`
extern void swap();  ////< `( n1 n2 -- n2 n1 )`
extern void over();  ///< `( n1 n2 -- n1 n2 n1 )`

/// @}

/// @}
