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

void setup(int argc, char* argv[]) {
    std::clog << \"setup:\\n\";
    for (int i = 0; i < argc; i++) arg(i,argv[i]);
}

int loop() {
    std::clog << \"loop:\\n\\texit\\n\";
    return 0;
}
"
    ()

let app () =
  touch "inc/app.hpp"
    ~c:"#pragma once
#include \"libc.hpp\"
#include \"main.hpp\"
" ();
  touch "src/app.cpp" ~c:"#include \"app.hpp\"
" ()

let libc () = touch "inc/libc.hpp" ~c:"#pragma once
#include <iostream>
" ()

let cpp () =
  mkd "inc" ();
  mkd "src" () main ();
  app ();
  libc ()
