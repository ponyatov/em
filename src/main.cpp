#include "app.hpp"

int main(int argc, char* argv[]) {
    Watch::init(argc, argv);
    setup(argc, argv);
    return loop();
}

void arg(int argc, char* argv) {
    std::clog << "\targ[" << argc << "] = <" << argv << ">\n";
}

__attribute__((weak)) void setup(int argc, char* argv[]) {
    std::clog << "setup:\n";
    arg(0, argv[0]);
    for (int i = 1; i < argc; i++) arg(i, argv[i]);
}

__attribute__((weak)) int loop() {
    std::clog << "loop:\n";
    while (true) {
        std::clog << '.';
        std::this_thread::sleep_for(std::chrono::seconds(1));
    }
    return 0;
}
