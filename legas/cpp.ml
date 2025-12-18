let main () =
  touch "inc/main.hpp"
    ~c:
      "#pragma once

extern int main(int argc, char* argv[]);
extern void arg(int argc, char* argv);
extern void setup(int argc, char* argv[]);
extern int loop();
"
    ();
  touch "src/main.cpp"
    ~c:
      "#include \"app.hpp\"

int main(int argc, char* argv[]) {
    setup(argc,argv);
    // for (int i = 1; i < argc; i++) arg(i, argv[i]);
    return loop();
}

void arg(int argc, char* argv) {
    std::clog << \"\\targ[\" << argc << \"] = <\" << argv << \"]\\n\";
}

__attribute__((weak)) void setup(int argc, char* argv[]) {
    std::clog << \"setup:\\n\";
    arg(0,argv[0]);
    for (int i = 1; i < argc; i++) arg(i,argv[i]);
}

__attribute__((weak)) int loop() {
    std::clog << \"loop:\\n\\texit\\n\";
    return 0;
}
"
    ()

let app () =
  touch "inc/app.hpp"
    ~c:
      "#pragma once
#include \"libc.hpp\"
//
#include \"vm.hpp\"
//
#include \"cli.hpp\"
#include \"main.hpp\"
"
    ();
  touch "src/app.cpp" ~c:"#include \"app.hpp\"
" ()

let libc () =
  touch "inc/libc.hpp"
    ~c:
      "#pragma once

#include <cassert>
#include <cstdio>
#include <cstdlib>
//
#include <iostream>
#include <sstream>
#include <string>
//
#include <map>
#include <vector>
//
#include <chrono>
#include <thread>
//
#include \"linux.hpp\"
"
    ()

let linux () =
  (* *)
  touch "inc/linux.hpp"
    ~c:
      "#pragma once

#include <sys/inotify.h>
#include <sys/types.h>
#include <x86intrin.h>
"
    ()

let cpp () =
  mkd "inc" ();
  mkd "src" ();
  main ();
  app ();
  libc ();
  linux ();
  Sys.command "git add inc src"
