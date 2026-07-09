/// @defgroup compiler compiler
/// @brief bytecode compiler (separated from @ref vm)
/// @ingroup cli
/// @{

#include "posix.hpp"
#include "vm.hpp"

extern std::map<std::string, addr> _label;

extern void label(std::string s);

extern addr compile(byte b);
extern addr compile(addr a);
extern addr compile(cell c);
extern addr compile(Op op);
extern addr compile(Op op, byte b);
extern addr compile(Op op, addr a);
extern addr compile(Op op, cell c);
/// @}
