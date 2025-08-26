/// @defgroup vm vm
/// @brief Virtual Machine (@ref bytecode)
/// @ingroup cli
/// @{

#ifndef _VM_HPP_
#define _VM_HPP_

/// @defgroup config config
/// @ingroup vm
/// @{
#define Msz 0x10000  ///< @ref M size, @ref byte s
#define Rsz 0x100    ///< @ref R size, @ref addr esses
#define Dsz 0x10     ///< @ref D size, @ref cell s
/// @}

/// @defgroup types types
/// @ingroup vm
/// @details
/// As @ref vm targets mostly for MCU-based devices, we can limit addressable
/// memory to 64K max, and use tiny stacks. So, we fixed @ref addr to 16-bit
/// wide, as smaler size is unusable, and larger size will only leave high bytes
/// always zeroed eating memory anyway tiny on most MCUs.
///
/// For larger targets, such as embedded Linux, mobile phone or full-size
/// desktops/servers, this limit also applicable, as we want to use a pile of
/// Erlang-like isolated processes each of them should be very compact and
/// release all its dynamic memory in a single @ref vm operation.
///
/// For @ref D data stack the 32-bit signed integer assumed enought for a real
/// use cases even on a large x86_64 machines. Here we agree with early Java ME
/// design considerations, but cutted down to Cortex-M0 devices (Java or eJS are
/// ugly fat even on Cortex-M4).
/// @{
#include <stdint.h>
typedef uint8_t byte;   ///< single byte
typedef uint16_t addr;  ///< @ref M address (limited for MCU little memory)
typedef int32_t cell;   ///< single integer (32-bit for MCU)
/// @}

/// @defgroup memory memory
/// @ingroup vm
/// @{
extern byte M[Msz];  ///< main memory, @ref byte s
extern addr Cp;      ///< compiler pointer
extern addr Ip;      ///< instruction pointer

extern addr R[Rsz];  ///< return stack, @ref addr esses
extern byte Rp;      /// @ref R pointer

extern cell D[Dsz];  ///< data stack, @ref cell s
extern byte Dp;      ///< @ref D pointer
/// @}

/// @defgroup command command
/// @ingroup vm
/// @{

/// command opcode
enum class Op {
    nop = 0x00,   ///< `00 ( -- )` @ref nop
    halt = 0xFF,  ///< `0F ( -- )` @ref halt
};

extern void nop();   ///< `( -- )` do nothing (empty command)
extern void halt();  ///< `( -- )` stop system
/// @}

extern bool trace;  ///< tracing mode flag

#endif  // _VM_HPP_

/// @}
