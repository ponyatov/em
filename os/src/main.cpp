#include "app.hpp"

std::thread background;

__attribute__((weak)) int main(int argc, char *argv[]) {
    arg(0, argv[0]);
    rl_init();
#ifdef DPDK
    std::cout << "\nrte:" << rte_eal_init(argc, argv) << '\n';
#endif
    setup();
    for (int i = 1; i < argc; i++) {  //
        arg(i, argv[i]);
        yyfile = argv[i];
        assert(yyin = fopen(yyfile, "r"));
        yyparse();
        fclose(yyin);
        yyfile = nullptr;
    }
    background = std::thread(loop);
    return rl_repl();
}

__attribute__((weak)) void arg(int argc, char *argv) {  //
    std::clog << "arg[" << argc << "] = <" << argv << ">\n";
}

__attribute__((weak)) void setup() {
    std::clog << "setup: ";
    std::clog << "ok\n";
}

__attribute__((weak)) bool stop = false;
__attribute__((weak)) void loop() {
    std::clog << "loop: ";
    std::clog << "stop\n";
    exit(0);
}
