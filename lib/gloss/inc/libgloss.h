/// @defgroup libgloss libgloss
/// @brief platform-specific wrappers for @ref libc
/// @ingroup libc
/// @{

/// @brief extend heap
extern char* sbrk(int nbytes);

/// @brief top of heap for @ref sbrk
extern char* heap_ptr;

/// @}
