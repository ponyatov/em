/// @defgroup os os
/// @ingroup cross

#ifndef _OS_HPP_
#define _OS_HPP_

#include "libc.hpp"

#ifdef LINUX
#include "linux.hpp"
#endif  // LINUX

#ifdef MINGW
#include "mingw.hpp"
#endif

#endif  // _OS_HPP_
