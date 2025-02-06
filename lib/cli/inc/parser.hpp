#pragma once

/// @defgroup parser parser
/// @ingroup cli
/// @brief `/interpreter/compiler`
/// @{

extern char *yyfile;  ///< current file name
extern int yyin;      ///< current file handler
extern int yylineno;  ///< current line number

/// @brief syntax error callback
extern void yyerror(const char *msg);

/// @brief parse disk file
extern void cli(char *filename);

/// @brief parse string in memory
/// @param[in] p data pointer (current position)
/// @param[in] pe data end pointer (end of data)
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
