/// @defgroup lexer lexer
/// @ingroup compiler
#pragma once

extern char *yyfile;                   //< current file name
extern size_t yyline;                  //< current line number
extern void lexer(char *p, char *pe);  ///< lexer

extern int to_int(char *ts, char *te);
extern int to_hex(char *ts, char *te);
extern int to_oct(char *ts, char *te);
extern int to_bin(char *ts, char *te);
extern float to_float(char *ts, char *te);
