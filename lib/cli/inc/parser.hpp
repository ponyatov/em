#pragma once

#include "libc.hpp"
#include "core.hpp"

/// @defgroup parser parser
/// @ingroup cli
/// @brief parser interface
/// @{

extern int yylex();              ///< lexer (`flex`)
extern int yylineno;             ///< current line
extern char *yytext;             ///< lexeme value
extern char *yyfile;             ///< current file name
extern FILE *yyin;               ///< current file handler
extern int yyparse();            ///< parser (`bison`)
extern void yyerror(char *msg);  ///< syntax error callback

#include "parser.yacc.hpp"

/// @brief construct token `(Class,ID)`
/// @param[in] C class name: calls `C(char*)` constructor
/// @param[in] X .yacc token identifier
#define TOKEN(C, X)               \
    {                             \
        yylval.o = new C(yytext); \
        return X;                 \
    }

/// @brief interpret file
extern void clif(char* filename);

/// @brief interpret string
extern void clis(char* str);

/// @brief interpret memory buffer
/// @param[in] p  lexer pointer (current position)
/// @param[in] pe lexer end pointer (end of data)
extern void cli(char* p, char* pe);

/// @name token conversion
/// @{
extern int dec(char *ts, char *te);    ///< decimal integer token
extern int hex(char *ts, char *te);    ///< hexadecimal token
extern int oct(char *ts, char *te);    ///< octal
extern int bin(char *ts, char *te);    ///< binary
extern float num(char *ts, char *te);  ///< floating point
/// @}

/// @}
