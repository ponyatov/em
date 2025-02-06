#include "cli.hpp"
#include "os.hpp"

char* yyfile = nullptr;
int yyin = 0;
int yylineno = 0;

void yyerror(const char* msg) {
    printf("\n\n%s:%i %s\n\n", yyfile, yylineno, msg);
    abort();
}
