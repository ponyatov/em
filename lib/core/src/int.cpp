#include "object.hpp"
#include "int.hpp"
#include "parser.hpp"
#include <string.h>

Int::Int(int n) : Prim(),value(n) {}
Int::Int(char *s) : Int(hex(s, s + strlen(s))) {}

Hex::Hex(char *s) : Int(hex(s, s + strlen(s))) {}
Oct::Oct(char *s) : Int(oct(s, s + strlen(s))) {}
Bin::Bin(char *s) : Int(bin(s, s + strlen(s))) {}
