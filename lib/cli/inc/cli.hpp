#pragma once
/// @defgroup cli cli
/// @brief @ref cli
/// @ingroup core
/// @{

/// @defgroup parser parser
/// @{
#ifdef POSIX
extern char* yyfile;  ///< current file name
extern int yyin;      ///< current file handler
#endif

/// @brief parse disk file
extern void cli(char* filename);

/// @brief parse string in memory
/// @param[in] p data pointer (current position)
/// @param[in] pe data end pointer (end of data)
extern void cli(char* p, char* pe);

extern int cli_cs;     ///< @brief current state
extern char* cli_eof;  ///< @brief end of file pointer
extern int cli_act;    ///<
extern char* cli_ts;   ///< @brief token start
extern char* cli_te;   ///< @brief token end

/// @}

/// @name commands
/// @{

extern void nop();   ///< `( -- )` do nothing: empty command
extern void halt();  ///< `( -- )` stop system

/// @}

/// @}
