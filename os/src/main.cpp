#include "os.hpp"

__attribute__((weak)) int main(int argc, char *argv[]) {
    arg(0, argv[0]);
    setup();
    for (int i = 1; i < argc; i++) {  //
        arg(i, argv[i]);
    }
    while (!stop) loop();
    return 0;
}

__attribute__((weak)) void arg(int argc, char *argv) {  //
    std::clog << "argv[" << argc << "] = <" << argv << "]\n";
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
