let doxygen () =
  Sys.command "doxygen -l" |> ignore;
  Sys.command "mv DoxygenLayout.xml doc/" |> ignore;
  touch ".doxygen"
    ~c:
      [%string "\
PROJECT_NAME           = \"%{app}\"
PROJECT_BRIEF          = \"%{title}\"
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
"]
    ()

let linux () =
  touch [%string "inc/linux.hpp"] ~c:[%string "\
#pragma once

/// @defgroup linux linux
/// @ingroup libc
/// @{
#include <sys/inotify.h>
#include <sys/types.h>
#include <time.h>
#include <x86intrin.h>
/// @{
"] ()

let libc () =
  touch [%string "inc/libc.hpp"] ~c:[%string "\
#pragma once

/// @defgroup libc libc
/// @{

/// @name C
/// @{
#include <cassert>
#include <csignal>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
/// @}
  
/// @name C++
/// @{
#include <iostream>
#include <sstream>
#include <string>
#include <map>
#include <vector>
/// @}

/// @name multicore
/// @{
#include <chrono>
#include <thread>
/// @}
/// @}
"] ();

let mainhpp () =
  touch [%string "inc/main.hpp"] ~c:[%string "\
#pragma once

/// @defgroup main main
/// @{
extern int main(int argc, char* argv[]);    ///< POSIX entry point
extern void arg(int argc, char* argv);      ///< process command line argument
extern void setup(int argc, char* argv[]);  ///< system setup
extern int loop();                          ///< event loop
/// @}
"]
    ()

let app () =
  touch [%string "inc/app.hpp"] ~c:[%string "\
#pragma once

#include \"libc.hpp\"
#include \"linux.hpp\"
#include \"main.hpp\"
#include \"watch.hpp\"
"] ();

let net () =
  touch [%string "inc/net.hpp"] ~c:[%string "\
#pragma once
"] ()

let hpp () =
  mkd "inc" ();
  libc(); linux (); mainhpp () ; app ();

let cpp () =
  touch
    ("src/" ^ app ^ ".cpp")
    ~c:
      ("#include \"" ^ app
     ^ ".hpp\"

int main(int argc, char *argv[]) {
    arg(0, argv[0]);
    for (int i = 1; i < argc; i++) {  //
        arg(i, argv[i]);
    }
}

void arg(int argc, char *argv) {  //
    std::cout << \"arg[\" << argc << \"] = <\" << argv << \"]\\n\";
}
"
      )
    ()


let cmake_any () =
  mkd "cmake" ();
  presets ();
  src ();
  Sys.command "cp ~/em/cmake/any_toolchain.cmake cmake/" |> ignore;
  Sys.command "cp ~/em/cmake/x86_64-linux-gnu.cmake cmake/" |> ignore;


let aptcpp () =
  let c =
    {|
g++ cmake pkg-config clang-format doxygen
gdb gdbserver valgrind cgroup-tools
flex bison ragel libreadline-dev
|}
  in
  append "apt.Debian" ~c:("code meld" ^ c) ();
  append "apt.Ubuntu" ~c ();
  append "apt.Raspbian" ~c ()

let cf () =
  Sys.command "cp ~/em/.clang-format ./" |> ignore;
  Sys.command "git add .clang-format" |> ignore

let cpplaunch () =
  touch ".vscode/launch.json"
    ~c:
      {|{
    "version": "0.2.0",
    "configurations": [
        {
            "name"            : "cmake:linux",
            "type"            : "cppdbg",
            "request"         : "launch",
            "cwd"             : "${workspaceFolder}",
            "program"         : "${command:cmake.launchTargetPath}",
            "args"            : ["lib/${workspaceFolderBasename}.ini"],
            "environment"     : [],
            "preLaunchTask"   : "CMake: build",
            "stopAtEntry"     : true,
            "externalConsole" : false,
            "MIMode"          : "gdb",
            "miDebuggerPath"  : "gdb",
            "setupCommands"   : [
                {"text": "-enable-pretty-printing","ignoreFailures": true},
                {"text": "source ${workspaceFolder}/.gdbinit","ignoreFailures": true}
            ]
        }
    ]
}
|}
    ()

let c_cpp_properties () =
  touch ".vscode/c_cpp_properties.json"
    ~c:
      {|{
    "version": 4,
    "env": {
        "appInclude": [
            "${workspaceFolder}/inc/**",
            "${workspaceFolder}/tmp/**",
            "${workspaceFolder}/src/**"
        ]
    },
    "configurations": [
        {
            "name"                 : "linux",
            "configurationProvider": "ms-vscode.cmake-tools",
            "mergeConfigurations"  : true,
            "includePath"          : ["${appInclude}"],
            "defines"              : ["PC", "I5", "X86_64", "LINUX"],
            "compilerPath"         : "/usr/bin/x86_64-linux-gnu-g++",
            "intelliSenseMode"     : "gcc-x64"
        }
    ]
}
|}
    ()

let cpp () =
  mkd "inc" ();
  mkd "src" ();
  hpp ();
  cpp ();
  cmake ();
  doxygen ();
  aptcpp ();
  cf ();
  cpplaunch ();
  c_cpp_properties ();
  Sys.command "git add .vscode doc cmake inc src"

let libhpp () =
  (* *)
  touch [%string "inc/%{app}.hpp"]
    ~c:[%string "\
#pragma once

#include <cstdlib>
#include <cstdio>

extern \"C\" void %{app}();
"] ()

let libcpp () =
  (* *)
  touch [%string "src/%{app}.cpp"]
    ~c:[%string "\
#include \"%{app}.hpp\"

void %{app}() { fprintf(stderr, \"Hello, %{app}\\n\"); }
"] ()

let liblists () =
  touch "CMakeLists.txt"
    ~c:
      [%string "cmake_minimum_required(VERSION 3.25)
get_filename_component(CMAKE_PROJECT_NAME ${CMAKE_SOURCE_DIR} NAME_WE)
project(${CMAKE_PROJECT_NAME} VERSION 0.0.1 LANGUAGES C CXX ASM)

include(src)      # scan project for source code files

add_library(${CMAKE_PROJECT_NAME} STATIC ${C} ${CP})

install(TARGETS ${CMAKE_PROJECT_NAME} DESTINATION .)
"]
    ();
  Sys.command "git add CMakeLists.txt"

let cpplib () =
  (* *)
  mkd "inc" (); mkd "src" ();
  cmake_any (); liblists ()
  libhpp ();
  libcpp ();
  doxygen ();
  cf ();
  c_cpp_properties ()
