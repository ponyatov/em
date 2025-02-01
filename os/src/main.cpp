#include "os.hpp"

int main(int argc, char *argv[]) {
    setup();
    arg(0, argv[0]);
    fprintf(stderr, "arg:\n");
    for (int i = 1; i < argc; i++) {
        arg(i, argv[i]);
        // #ifdef CLI
        //         yyfile = argv[i];
        //         assert(yyin = fopen(argv[i], "r"));
        //         yyparse();
        //         fclose(yyin);
        //         yyfile = nullptr;
        // #endif
    }
    for (;;) loop();
    return 0;
}

extern void arg(int argc, char *argv) {  //
    fprintf(stderr, "\targ[%i] = <%s>\n", argc, argv);
}

void setup() {  //
    fprintf(stderr, "setup:\n");
}

#include "cli.hpp"

void loop() {
    fprintf(stderr, "loop:\n");
    bye();
}
