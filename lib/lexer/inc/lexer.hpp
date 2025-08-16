/// @defgroup lexer lexer
/// @brief `ragel`
/// @ingroup compiler
/// @{
#pragma once
#include <stdint.h>

extern char *yyfile;                   //< current file name
extern size_t yyline;                  //< current line number
extern void lexer(char *p, char *pe);  ///< lexer

extern int32_t to_int(char *ts, char *te);
extern uint32_t to_hex(char *ts, char *te);
extern uint32_t to_oct(char *ts, char *te);
extern uint32_t to_bin(char *ts, char *te);
extern float to_float(char *ts, char *te);
/// @}
