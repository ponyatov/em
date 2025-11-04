#pragma once

#include <cstdio>
#include <string>

/// @defgroup syntax syntax
/// @brief command/syntax parser
/// @{
extern int yylex();                    ///< lexer
extern int yylineno;                   ///< line number
extern char *yyfile;                   ///< current file name
extern FILE *yyin;                     ///< file handler
extern char *yytext;                   ///< lexeme (token) string value
extern void parse(char *);             ///< parse string
extern int yyparse();                  ///< parser
extern void yyerror(std::string msg);  ///< syntax error callback
#include "cql.yacc.hpp"
/// @}
