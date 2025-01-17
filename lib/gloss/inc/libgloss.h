/// @defgroup libgloss libgloss
/// @brief platform-specific wrappers for @ref libc
/// @ingroup libc
/// @{

/// @brief expand heap
extern char* sbrk(int nbytes);

/// @brief top of heap for @ref sbrk
extern char* heap_ptr;

/// @}
