#include "vm.hpp"
#include "cli.hpp"

__attribute__((weak)) void cli(char* filename) {
    yyfile = filename;
    assert(yyin = fopen(yyfile, "r"));
    yyparse();
    fclose(yyin);
    yyfile = nullptr;
}
