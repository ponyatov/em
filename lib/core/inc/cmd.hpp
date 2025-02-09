#pragma once

#include "object.hpp"

/// @defgroup cmd cmd
/// @ingroup vm
/// @brief @ref VM command
/// @{

/// @brief command opcode for @ref bc generation
typedef u8 Op;

/// @brief @ref VM command
class Cmd : public Object {
   public:
    void exec();  ///< execute command over global @ref vm
   private:
    static const Op op;  ///< command opcode for @ref bc generation
};

/// @defgroup fctl flow control
/// @brief `0x00..0F, FF`
/// @{

/// `0x00` `( -- )` empty command: do nothing
class Nop : public Cmd {
    static const Op op = 0x00;
};

/// `0xFF` `( -- )` stop system
class Halt : public Cmd {
    static const Op op = 0xFF;
};

/// @}

/// @defgroup stackop stack ops
/// @brief `0x10..17`
/// @{

/// `0x10` `( n -- n n )`
class Dup : public Cmd {
    static const Op op = 0x10;
};

/// `0x11` `( n -- )`
class Drop : public Cmd {
    static const Op op = 0x11;
};

/// `0x12` `( n1 n2 -- n2 n1 )`
class Swap : public Cmd {
    static const Op op = 0x12;
};

/// `0x13` `( n1 n2 -- n1 n2 n1 )`
class Over : public Cmd {
    static const Op op = 0x13;
};

/// `0x14` `( n1 n2 n3 -- n2 n3 n1 )`
class Rot : public Cmd {
    static const Op op = 0x14;
};

/// `0x15` `( n1 n2 n3 -- n3 n1 n2 )`
class mRot : public Cmd {
    static const Op op = 0x15;
};

/// `0x16` `( ... ni ... n0 i -- ... ni ... n0 ni )` pick element by index
class Pick : public Cmd {
    static const Op op = 0x16;
};

/// `0x17` `( ni ... -- ni ... i )` current stack depth
class Depth : public Cmd {
    static const Op op = 0x17;
};

/// @}

/// @defgroup math math
/// @brief `0x20..24`
/// @{

/// `0x20` `( n1 n2 -- n1+n2 )`
class Add : public Cmd {
    static const Op op = 0x20;
};

/// `0x21` `( n1 n2 -- n1-n2 )`
class Sub : public Cmd {
    static const Op op = 0x21;
};

/// `0x22` `( n1 n2 -- n1*n2 )`
class Mul : public Cmd {
    static const Op op = 0x22;
};

/// `0x23` `( n1 n2 -- n1/n2 )`
class Div : public Cmd {
    static const Op op = 0x23;
};

/// `0x24` `( n1 n2 -- n1**n2 )`
class Pow : public Cmd {
    static const Op op = 0x24;
};

/// @}

/// @defgroup bit bit ops
/// @brief `0x25..2A`
/// @{

/// `0x25` `( n1  -- !n1 )`
class Not : public Cmd {
    static const Op op = 0x25;
};

/// `0x26` `( n1 n2 -- n1|n2 )`
class Or : public Cmd {
    static const Op op = 0x26;
};

/// `0x27` `( n1 n2 -- n1&n2 )`
class And : public Cmd {
    static const Op op = 0x27;
};

/// `0x28` `( n1 n2 -- n1^n2 )`
class Xor : public Cmd {
    static const Op op = 0x28;
};

/// `0x29` `( n1 n2 -- n1<<n2 )`
class Lsh : public Cmd {
    static const Op op = 0x29;
};

/// `0x2A` `( n1 n2 -- n1>>n2 )`
class Rsh : public Cmd {
    static const Op op = 0x2A;
};

/// @}

/// @defgroup memory memory
/// @brief `0x30..37`
/// @{

/// `0x30` `( addr -- i8/u8 )` fetch byte
class Ld8 : public Cmd {
    static const Op op = 0x30;
};

/// `0x31` `( addr -- i16/u16 )` fetch short
class Ld16 : public Cmd {
    static const Op op = 0x31;
};

/// `0x32` `( addr -- i32/u32 )` fetch int
class Ld32 : public Cmd {
    static const Op op = 0x32;
};

/// `0x33` `( addr -- i64/u64 )` fetch long
class Ld64 : public Cmd {
    static const Op op = 0x33;
};

/// `0x34` `( i8/u8 addr -- )` store byte
class St8 : public Cmd {
    static const Op op = 0x34;
};

/// `0x35` `( i16/u16 addr -- )` store short
class St16 : public Cmd {
    static const Op op = 0x35;
};

/// `0x36` `( i32/u32 addr -- )` store int
class St32 : public Cmd {
    static const Op op = 0x36;
};

/// `0x37` `( i64/u64 addr -- )` store long
class St64 : public Cmd {
    static const Op op = 0x37;
};

/// @}

/// @defgroup iops io
/// @brief `0x40..`
/// @{

/// `0x10` `( -- c )` read single char from input/console
class Key : public Cmd {
    static const Op op = 0x40;
};

/// `0x11` `( c -- )` put single char to output/console
class Emit : public Cmd {
    static const Op op = 0x41;
};

/// @}

/// @}
