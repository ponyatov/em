
#include "bc.hpp"
#include "cli.hpp"
#include "debug.hpp"
#include "lib.hpp"
#include "main.hpp"
#include "vm.hpp"

int main(int argc, char* argv[]) {
    fprintf(stderr, "" APP "\n");
    arg(0, argv[0]);
    init(argc, argv);

    // auto session = dap::Session::create();

    for (int i = 1; i < argc; i++) {
        arg(i, argv[i]);
        yyfile = argv[i];
        yylineno = 1;
        assert(yyin = fopen(yyfile, "r"));
        yyparse();
        fclose(yyin);
        yyfile = nullptr;
    }
    return vm();
}

void arg(int argc, char* argv) {  //
    fprintf(stderr, "%i: %s\n", argc, argv);
}

void init(int, char*[]) {}

int fini() { return 0; }
