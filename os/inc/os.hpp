#pragma once

/// @defgroup os os
/// @ingroup cross

/// @defgroup main main
/// @ingroup core
/// @{
extern int main(int argc, char *argv[]);
extern void arg(int argc, char *argv);
extern void setup();
extern void loop();
/// @}

#ifdef LINUX
#include "linux.hpp"
#endif
