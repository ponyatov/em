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

let timer () =
  touch "inc/timer.hpp" ~c:"#pragma once

/// @defgroup timer timer
/// @{
extern void rdtsc();  ///< `( ns -- )` run timer `ns` nanoseconds
/// @}
" ();
  touch "src/timer.cpp" ~c:"" ();

let mproc () =
  touch "inc/mproc.hpp" ~c:"" ();
  touch "src/mproc.cpp" ~c:"" ()

let aptcpp () =
  let c = "
g++ cmake pkg-config clang-format
gdb gdbserver valgrind cgroup-tools
flex bison ragel libreadline-dev
" in
  append "apt.Debian" ~c:("code meld doxygen"^c) ();
  append "apt.Ubuntu" ~c:("doxygen"^c) ();

let cf () =
  Sys.command "cp ~/em/.clang-format ./" |> ignore;
  Sys.command "git add .clang-format"|> ignore

let cpplaunch () =
  touch ".vscode/launch.json"
    ~c:
      "{
    \"version\": \"0.2.0\",
    \"configurations\": [
        {
            \"name\"            : \"cmake:linux\",
            \"type\"            : \"cppdbg\",
            \"request\"         : \"launch\",
            \"cwd\"             : \"${workspaceFolder}\",
            \"program\"         : \"${command:cmake.launchTargetPath}\",
            \"args\"            : [\"lib/${workspaceFolderBasename}.ini\"],
            \"environment\"     : [],
            \"preLaunchTask\"   : \"CMake: build\",
            \"stopAtEntry\"     : true,
            \"externalConsole\" : false,
            \"MIMode\"          : \"gdb\",
            \"miDebuggerPath\"  : \"gdb\",
            \"setupCommands\"   : [
                {\"text\": \"-enable-pretty-printing\",\"ignoreFailures\": true},
                {\"text\": \"source ${workspaceFolder}/.gdbinit\",\"ignoreFailures\": true}
            ]
        }
    ]
}
"
    ()

let c_cpp_properties () =
  touch ".vscode/c_cpp_properties.json"
    ~c:
      "{
    \"version\": 4,
    \"env\": {
        \"appInclude\": [
            \"${workspaceFolder}/inc/**\",
            \"${workspaceFolder}/tmp/**\",
            \"${workspaceFolder}/src/**\",
            \"${workspaceFolder}/lib/inc/**\" ,\"${workspaceFolder}/lib/*/inc/**\"
        ]
        \"crossInclude\": [
            \"${workspaceFolder}/hw/inc/**\"  ,\"${workspaceFolder}/hw/*/inc/**\"  ,
            \"${workspaceFolder}/cpu/inc/**\" ,\"${workspaceFolder}/cpu/*/inc/**\" ,
            \"${workspaceFolder}/arch/inc/**\",\"${workspaceFolder}/arch/*/inc/**\",
            \"${workspaceFolder}/os/inc/**\"  ,\"${workspaceFolder}/os/*/inc/**\"
        ]
    },
    \"configurations\": [
        {
            \"name\"                 : \"linux\",
            \"configurationProvider\": \"ms-vscode.cmake-tools\",
            \"mergeConfigurations\"  :  true,
            \"includePath\"          : [\"${appInclude}\", \"${crossInclude}\"],
            \"defines\"              : [\"PC\", \"I5\", \"X86_64\", \"LINUX\"],
            \"compilerPath\"         : \"/usr/bin/x86_64-linux-gnu-g++\",
            \"cStandard\"            : \"c17\",
            \"cppStandard\"          : \"c++23\",
            \"intelliSenseMode\"     : \"gcc-x64\"
        }
    ]
}
"
    ()

let doxygen () =
  Sys.command "doxygen -l" |> ignore;
  Sys.command "mv DoxygenLayout.xml doc/" |> ignore;
  touch ".doxygen"
    ~c:
      ("
PROJECT_NAME           = \"" ^ app ^ "\"
PROJECT_BRIEF          = \""
     ^ title
     ^ "\"
PROJECT_LOGO           = doc/logo.png
LAYOUT_FILE            = doc/DoxygenLayout.xml
OUTPUT_DIRECTORY       = doc
HTML_OUTPUT            = html
INPUT                  = README.md doc inc src
INPUT                 += hw cpu arch os
INCLUDE_PATH           = inc
EXCLUDE                = ref/* lib/python* *.pdf *.djvu
WARN_IF_UNDOCUMENTED   = NO
RECURSIVE              = YES
USE_MDFILE_AS_MAINPAGE = README.md
GENERATE_LATEX         = NO
FILE_PATTERNS         += *.lex *.yacc *.ragel *.rl
EXTENSION_MAPPING      = lex=C++ yacc=C++ ragel=C++ rl=C++ ino=C++
HAVE_DOT               = YES
EXTRACT_ALL            = YES
EXTRACT_STATIC         = YES
EXTRACT_PRIVATE        = YES
EXTRACT_PACKAGE        = YES
EXTRACT_LOCAL_CLASSES  = YES
EXTRACT_LOCAL_METHODS  = YES
EXTRACT_ANON_NSPACES   = YES
SORT_GROUP_NAMES       = YES
REPEAT_BRIEF           = NO
CALL_GRAPH             = YES
CALLER_GRAPH           = YES
"
      )
    ()

let cpp () =
  mkd "inc" ();
  mkd "src" ();
  main ();
  app ();
  libc ();
  linux ();
  timer();
  mproc();
  aptcpp();
  cf();
  cpplaunch();c_cpp_properties();
  doxygen();
  Sys.command "git add doc inc src"
