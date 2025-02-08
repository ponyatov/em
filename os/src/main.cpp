#include "os.hpp"
#include "cli.hpp"

#ifdef POSIX
__attribute__((weak)) int main(int argc, char *argv[]) {  //
    printf("setup:\n");
    setup();
    printf("arg:\n");
    arg(0, argv[0]);
    for (int i = 1; i < argc; i++) arg(i, argv[i]);
    printf("loop:\n");
    for (;;) loop();
    return 0;
}
#endif  // POSIX

__attribute__((weak)) void setup() {  //
    printf("\tok\n");
}

__attribute__((weak)) void arg(int argc, char *argv) {  //
    printf("\targ[%i] = <%s>\n", argc, argv);
#ifdef POSIX
    if (argc) cli(argv);
#endif
}

__attribute__((weak)) void loop() {  //
    printf("\tstop\n");
    exit(0);
}
