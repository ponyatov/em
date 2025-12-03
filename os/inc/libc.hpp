#pragma once
/// @defgroup libc libc
/// @ingroup lib
/// @{

#include <cstdint>
static_assert(sizeof(int) == sizeof(int32_t));
static_assert(sizeof(long) == sizeof(int64_t));

#include <cassert>
#include <csignal>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <iomanip>
#include <iostream>
#include <map>
#include <sstream>
#include <string>
#include <thread>
#include <vector>
/// @}
