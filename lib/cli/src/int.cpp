#include "int.hpp"
#include "syntax.hpp"
#include <string>

Int::Int(char *c) : Object() { value = atoi(c); }
Int::Int(int n) : Object() { value = n; }

Hex::Hex(char *c) : Int(std::stol(c, nullptr, 0x10)) {}
Oct::Oct(char *c) : Int(std::stol(c, nullptr, 0x08)) {}
Bin::Bin(char *c) : Int(std::stol(c, nullptr, 0x02)) {}
