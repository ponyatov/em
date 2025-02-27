/// @defgroup libc libc
/// @ingroup core
/// @{

#include <stdint.h>

/// @name memory
/// @{

/** @brief get a memory block */
/// @returns void* | -1
/// @details uses @ref sbrk for memory expand
extern void* malloc(size_t nbytes);

/// @}
/// @}
