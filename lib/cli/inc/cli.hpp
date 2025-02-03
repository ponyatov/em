#pragma once
/// @defgroup cli cli
/// @brief @ref cli
/// @ingroup core
/// @{

/// @defgroup parser parser
/// @{
#ifdef POSIX
extern char *yyfile;  ///< current file name
extern int yyin;      ///< current file handler
#endif

/// @brief parse disk file
extern void cli(char *filename);

/// @brief parse string in memory
/// @param[in] p data pointer (current position)
/// @param[in] pe data end pointer (end of data)
extern void cli(char *p, char *pe);

/// @name token conversion
/// @{
extern int dec(char *ts, char *te);    ///< decimal integer token
extern int hex(char *ts, char *te);    ///< hexadecimal token
extern int oct(char *ts, char *te);    ///< octal
extern int bin(char *ts, char *te);    ///< binary
extern float num(char *ts, char *te);  ///< floating point
/// @}

/// @}

/// @}
