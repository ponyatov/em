/// @defgroup linux linux
/// @ingroup os
/// @{

#ifndef _LINUX_HPP_
#define _LINUX_HPP_

#include <fcntl.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <unistd.h>

/// @defgroup main main
/// @ingroup linux
/// @{

/// @brief POSIX entry point
/// @param[in] argc arguments count
/// @param[in] argv arguments array (`argv[0]` = program/firmware name)
extern int main(int argc, char *argv[]);

/// @brief callback for processing command line / boot loader arguments
/// @param[in] argc argument index (0 = program/firmware name)
/// @param[in] argv argument string value
extern void arg(int argc, char *argv);

/// @}

#endif  // _LINUX_HPP_
/// @}
