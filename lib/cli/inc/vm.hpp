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
extern byte Rp;      ///< @ref R top pointer

extern cell D[Dsz];  ///< data stack, @ref cell s
extern byte Dp;      ///< @ref D top pointer

/// @brief @ref M / bytecode image header
/// @details contains initial registers and memory allocations
///
/// actual registers values must be @ref sync_ ed into memory image before
/// hybernation, @ref save bytecode file dump, or cross-node migration
struct bcHeader {
    /// signature
    char magic[4] = "bcx";
    /// max @ref M size, bytes
    uint32_t max = Msz;
    /// @ref Cp initial value
    addr Cp = 0;
    /// @brief @ref Ip initial value (entry point)
    /// @details
    addr Ip = 0;
    /// @brief max @ref R size (check <= @ref Rp)
    addr Rmax = 0;
    /// @brief max @ref D size (check <= @ref Dp)
    addr Dmax = 0;
    /// @brief LFA of last defined word in FORTH vocabulary
    /// @details =0 in case of no vocabulary compiled
    addr latest = 0;
};
/// @}

/// @defgroup command command
/// @ingroup vm
/// @{

/// command opcode
enum class Op {
    nop = 0x00,   ///< `00 ( -- )` @ref nop
    halt = 0xFF,  ///< `0F ( -- )` @ref halt
    jmp = 0x01,   ///< `01 ( -- )` @ref jmp
    qjmp = 0x02,  ///< `02 ( -- )` @ref qjmp
    call = 0x03,  ///< `03 (R: -- addr )` @ref call
    ret = 0x04,   ///< `04 (R: -- )` @ref ret
    lit = 0x05,   ///< `05 ( -- n )`@ref lit
    lits = 0x06,  ///< `06 ( -- s )`@ref lits
    litb = 0x07,  ///< `07 ( -- b )`@ref litb
    dot = 0x10,   ///< `10 ( -- )`
    dup,          ///< `( a -- a a )`
    drop,         ///< `( a b -- a )`
    swap,         ///< `( a b -- b a )`
    over,         ///< `( a b -- a b a )`
    rot,          ///< `( a b c -- b c a )`
    mrot,         ///< `( a b c -- c a b )`
    pick,         ///< `( ... i -- ... D[i] )`
    depth,        ///< `( -- Dp )`
    dump = 0x70,  ///< `70 ( -- )`
    init = 0xF0,  ///< `F0 ( -- )` @ref init
    sync,         ///< `F0 ( -- )` @ref sync_
    save          ///< `F1 ( -- )` @ref save
};

/// @name system control

extern void nop();    ///< `( -- )` do nothing (empty command)
extern void halt();   ///< `( -- )` stop system
extern void init();   ///< `( -- )` init bytecode engine
extern void sync_();  ///< `( -- )` sync registers into @ref bcHeader
extern void save();   ///< `( -- )` dump @ref M bytecode dump into `tmp/dump.bc`

/// @name flow control

extern void jmp();   ///< `( -- )` unconditional jump
extern void jz();    ///< `( bool -- )` jump if `false`
extern void call();  ///< `( -- )`
extern void ret();   ///< `( -- )`

/// @name data stack literals
extern void lit();   ///< `( -- )`
extern void lits();  ///< `( -- )`
extern void litb();  ///< `( -- )`

/// @name data stack ops
extern void dot();    ///< `( ... -- )` clean @ref D stack
extern void dup();    ///< `( -- )`
extern void drop();   ///< `( -- )`
extern void swap();   ///< `( -- )`
extern void over();   ///< `( -- )`
extern void rot();    ///< `( -- )`
extern void mrot();   ///< `( -- )`
extern void pick();   ///< `( -- )`
extern void depth();  ///< `( -- )`

extern void push(cell n);  //< `( -- n )`
extern cell pop();         //< `( n -- )`
extern cell top();         //< `( n -- n )`

/// @name debug
extern void dump();  ///< `( -- )` dump @ref vm state
/// @}

extern bool trace;  ///< tracing mode flag

#endif  // _VM_HPP_

/// @}
