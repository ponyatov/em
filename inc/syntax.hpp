#pragma once

#include <cstdio>
#include <string>

/// @defgroup syntax syntax
/// @{
extern int yylex();
extern int yylineno;
extern char* yytext;
extern char* yyfile;
extern FILE* yyin;
extern int yyparse();
extern void yyerror(std::string msg);
#include "cql.yacc.hpp"
/// @}
