#pragma once

/// @defgroup os os
/// @ingroup cross

/// @defgroup main main
/// @ingroup core
/// @{
extern int main(int argc, char *argv[]);
extern void arg(int argc, char *argv) __attribute__((weak));
extern void setup() __attribute__((weak));
extern void loop() __attribute__((weak));
/// @}

#ifdef LINUX
#include "linux.hpp"
#endif
