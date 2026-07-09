/// @defgroup cli cli
/// @brief REPL: command-line interface (uses @ref vm for compile & run)
/// @ingroup lib
#pragma once

#include "posix.hpp"
#include "vm.hpp"
#include "syntax.hpp"
#include "compiler.hpp"

extern void cli(char *filename);  ///< process script file

/// @}
