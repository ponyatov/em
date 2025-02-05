#pragma once

/// @defgroup os os
/// @ingroup cross

/// @defgroup main main
/// @ingroup os
/// @{

/// @brief POSIX entry point
/// @param[in] argc arguments count
/// @param[in] argv arguments array (`argv[0]` = program/firmware name)
extern int main(int argc, char *argv[]);

/// @brief first call: callback on system startup
extern void setup();

/// @brief callback for processing command line / boot loader arguments
/// @param[in] argc argument index (0 = program/firmware name)
/// @param[in] argv argument string value
extern void arg(int argc, char *argv);

/// @brief application event loop callback
extern void loop();

/// @}

#ifdef POSIX
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#endif  // POSIX

#ifdef LINUX
#include "linux.hpp"
#endif

#ifdef MINGW
#include "mingw.hpp"
#endif
