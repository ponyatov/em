#include "main.hpp"
#include "linux.hpp"
#include "app.hpp"

int main(int argc, char *argv[]) {
    setup();
    arg(0, argv[0]);
    for (int i = 1; i < argc; i++) {
        fprintf(stderr, "arg[%i] = <%s>\n", argc, argv);
        arg(i, argv[i]);
#ifdef CLI
        yyfile = argv[i];
        assert(yyin = fopen(argv[i], "r"));
        yyparse();
        fclose(yyin);
        yyfile = nullptr;
#endif
    }
    for (;;) loop();
    return 0;
}
