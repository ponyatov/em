/// @defgroup rl rl
/// @brief console command-line editor (readline)
/// @ingroup cli
/// @{
#pragma once

#include <readline/history.h>
#include <readline/readline.h>

class RL {
   public:
    static void init();  ///< run at @ref main start
    static void fini();  ///< cleanup (dump history, etc)
    static int repl();   ///< REPL loop
    static int counter;  ///< commands counter
};
/// @}
