#include "os.hpp"

__attribute__((weak)) int main(int argc, char *argv[]) {  //
    arg(0, argv[0]);
    for (int i = 1; i < argc; i++) {  //
        arg(i, argv[i]);
    }
    setup();
    for (;;) loop();
    return 0;
}

__attribute__((weak)) void arg(int argc, char *argv) {  //
    std::clog << "argv[" << argc << "] = <" << argv << "]\n";
}
