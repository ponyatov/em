/// @defgroup main main
/// @ingroup lib
/// @brief startup/shutdown
/// @{
#pragma once

#include "hal.hpp"

extern int main(int argc, char* argv[]);  ///< POSIX entry point
extern void arg(int argc, char* argv);  ///< print single command line argument
extern void init(int argc, char* argv[]);  ///< system init
extern int fini();  ///< system shutdown (with fake return from @ref main)

/// @}
