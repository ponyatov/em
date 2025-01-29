#include "app.hpp"

extern void yyerror(const char *msg) {  //
#ifdef LIBC
    fprintf(stderr, "\n%s:%i %s [%s]\n\n", yyfile, yylineno, msg, yytext);
    exit(-1);
#endif
}
