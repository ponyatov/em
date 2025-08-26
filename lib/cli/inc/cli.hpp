/// @defgroup cli cli
/// @ingroup lib

#ifndef _CLI_HPP_
#define _CLI_HPP_

#include "os.hpp"

extern int yylex();                    ///< lexer (`flex`)
extern int yylineno;                   ///< current line
extern char *yyfile;                   ///< current file name
#ifdef LEMON
extern int yyin;                       ///< current file handler
#else
extern FILE *yyin;                     ///< current file handler
#endif // LEMON
extern char *yytext;                   ///< token lexeme value
extern int yyparse();                  ///< parser (`bison`)
extern void yyerror(const char *msg);  ///< syntax error callback

#endif  // _CLI_HPP_
