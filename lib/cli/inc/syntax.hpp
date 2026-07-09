/// @defgroup syntax syntax
/// @brief syntax parser
/// @ingroup cli
/// @{
#pragma once

#include <string>

/// @name lexer
/// @{
extern int yylex();        ///< lexer (`flex`)
extern int yylineno;       ///< line number
extern char *yytext;       ///< lexeme (token) string value
extern char *yyfile;       ///< current file name
extern std::string yystr;  ///< buffer for block lexing (string, comment,..)
extern FILE *yyin;         ///< script file handler
/// @}

/// @name parser
/// @{
extern int yyparse();                  ///< parser (`bison`)
extern void parse(char *);             ///< parse string
extern void yyerror(const char *msg);  ///< syntax error callback
#include "cli.yacc.hpp"
/// @}

/// @defgroup num num
/// @brief number parsers
/// @{
extern float num(char *s);  ///< @returns float
extern int dec(char *s);    ///< @returns decimal
extern int hex(char *s);    ///< @returns hexadecimal
extern int oct(char *s);    ///< @returns octal
extern int bin(char *s);    ///< @returns binary
/// @}
