#pragma once

/// @defgroup os os
/// @ingroup cross

#include "main.hpp"

#include <stdio.h>
#include <stdlib.h>
#ifdef POSIX
#include <assert.h>
#include <string.h>
#endif  // POSIX

#ifdef LINUX
#include "linux.hpp"
#endif

#ifdef MINGW
#include "mingw.hpp"
#endif
