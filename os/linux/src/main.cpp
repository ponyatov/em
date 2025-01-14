#include "main.hpp"
#include "linux.hpp"

int main(int argc, char *argv[]) {
    arg(0, argv[0]);
    for (int i = 1; i < argc; i++) {
        arg(i, argv[i]);
#ifdef CLI
        yyfile = argv[i];
        assert(yyin = fopen(argv[i], "r"));
        yyparse();
        fclose(yyin);
        yyfile = nullptr;
#endif
    }
    return 0;
}

void arg(int argc, char *argv) {  //
    fprintf(stderr, "arg[%i] = <%s>\n", argc, argv);
}
