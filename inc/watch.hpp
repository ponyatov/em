#pragma once

#include "app.hpp"

class Watch {
    static std::vector<std::thread *> threads;  ///< file wather threads
    static void watch(int argc, char *argv);    ///< inotify background worker

   public:
    /// watch on file changed: exit(1) on config/binary/source change
    static void init(int argc, char *argv[]);
    static void signal_handler(int signal);
};
