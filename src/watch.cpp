#include "app.hpp"

std::vector<std::thread *> Watch::threads;

void Watch::init(int argc, char *argv[]) {
    signal(SIGINT, Watch::signal_handler);

    // for (int i = 0; i < argc; i++)
    Watch::threads.push_back(new std::thread(Watch::watch, 0, argv[0]));
}

void Watch::signal_handler(int signal) {
    // fprintf(stderr, "'\n\nsignal:%i\n\n", signal);
    std::clog << "\n\nsignal:" << signal << "\n\n";
    switch (signal) {
        case SIGSTOP:
            std::cerr << "\nSIGSTOP\n";
            break;
        case SIGINT:  // kill -2
            std::cerr << "\nSIGINT: Interrupted! (Ctrl+C pressed)\n";
            exit(signal);
            break;
        case SIGQUIT:  // kill -3
            std::cerr << "\nSIGQUIT: Quit\n";
        case SIGKILL:  // kill -9
            std::cerr << "\nSIGKILL\n";
            break;
        case SIGTERM:  // async stop program
            std::cerr << "\nSIGKILL\n";
            break;
        default:
            abort();
    }
    // Config::stop();
}

void Watch::watch(int argc, char *argv) {
    int fd = inotify_init();
    inotify_add_watch(fd, argv, IN_ALL_EVENTS);
    /// wait
    char buf[1024];
    read(fd, buf, sizeof(buf));
    /// terminate
    // Dev::stop();
    std::clog << "\nwatch:\n\t" << argv << "\n\n";
    // restart process using make loop
    exit(1);
}
