/// @defgroup os os
/// @ingroup cross

#pragma once

#include "libc.hpp"

#ifdef LINUX
#include "linux.hpp"
#endif  // LINUX

#ifdef MINGW
#include "mingw.hpp"
#endif
