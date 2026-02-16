let cMakeLists () =
  touch "CMakeLists.txt"
    ~c:
      "cmake_minimum_required(VERSION 3.25)
get_filename_component(CMAKE_PROJECT_NAME ${CMAKE_SOURCE_DIR} NAME_WE)
project(${CMAKE_PROJECT_NAME} VERSION 0.0.1 LANGUAGES C CXX ASM)

include(version)  # binary files naming by version & git branch/hash
include(src)      # scan project for source code files
include(syntax)   # parser generators (flex,yacc/bison,ragel,lemon,..)

message(\"-- |\")
message(\"-- | toolchain: \" ${CMAKE_CXX_COMPILER} \" @ \" ${CMAKE_TOOLCHAIN_FILE})
message(\"-- |      host: \" ${CMAKE_HOST_SYSTEM_NAME}-${CMAKE_HOST_SYSTEM_VERSION})
message(\"-- |    target: \" \"hw:\" ${HW} \" cpu:\" ${CPU} \" arch:\" ${ARCH} \" os:\" ${OS})
message(\"-- |   startup: \" \"${S}\")
message(\"-- |    linker: \" \"${LD}\")
message(\"-- |    binary: \" \"${CMAKE_INSTALL_PREFIX}/${BIN_OUTPUT_NAME}${CMAKE_EXECUTABLE_SUFFIX}\")
message(\"-- |      data: \" \"${DATA}\")
message(\"-- |       ini: \" \"${INI}\")
message(\"-- |\")

add_executable(${CMAKE_PROJECT_NAME}
    ${C}  ${H}          # C/C++ source
    ${S}  ${LD}         # embedded/lowlevel
    ${CP} ${HP}         # parsers
    ${DATA}             # precompiled binary data (bytecode,..)
    ${INI}              # init/config files & scripts
)

include(install) # target install
include(clean)   # project clean-up (remove generated & temp files)
"
    ()

let cMakePresets () =
  touch "CMakePresets.json"
    ~c:
      "{
    \"version\": 6,
    \"buildPresets\": [
        {
            \"name\"            :  \"linux\",
            \"configurePreset\" :  \"linux\",
            \"targets\"         : [\"all\",\"install\"],
            \"jobs\"            :   4
        }
    ],
    \"configurePresets\": [
        {
            \"name\"            : \"common\",
            \"hidden\"          :  true,
            \"binaryDir\"       : \"${sourceDir}/tmp/${presetName}\",
            \"generator\"       : \"Unix Makefiles\",
            \"cacheVariables\"  : {
                \"CMAKE_INSTALL_PREFIX\"    : \"${sourceDir}/bin\",
                \"CMAKE_MODULE_PATH\"       : \"${sourceDir}/cmake\",
                \"CMAKE_COLOR_DIAGNOSTICS\" :  false,
                \"CMAKE_BUILD_TYPE\"        : \"Debug\",
                \"CMAKE_VERBOSE_MAKEFILE\"  :  false
            }
        },
        {
            \"name\"            : \"pc\",
            \"inherits\"        : \"common\",
            \"hidden\"          : true,
            \"cacheVariables\"  : {\"HW\":\"pc\", \"CPU\":\"i5\", \"ARCH\":\"x86_64\"}
        },
        {
            \"name\"            : \"linux\",
            \"inherits\"        : \"pc\",
            \"displayName\"     : \"x86_64-linux-gnu\",
            \"toolchainFile\"   : \"${sourceDir}/cmake/x86_64-linux-gnu.cmake\",
            \"cacheVariables\"  : {\"OS\":\"linux\"}
        }
    ]
}
"
    ()

let src () =
  touch "cmake/src.cmake"
    ~c:
      "
# file(GLOB LD -> cmake/any_toolchain.cmake

file(GLOB_RECURSE S
    RELATIVE ${CMAKE_SOURCE_DIR} CONFIGURE_DEPENDS
    src/*.s
)

file(GLOB_RECURSE C
    RELATIVE ${CMAKE_SOURCE_DIR} CONFIGURE_DEPENDS
    src/*.c*
)

file(GLOB_RECURSE H
    RELATIVE ${CMAKE_SOURCE_DIR} CONFIGURE_DEPENDS
    inc/*.h*
)

file(GLOB INC
    RELATIVE ${CMAKE_SOURCE_DIR} CONFIGURE_DEPENDS
    ${CMAKE_BINARY_DIR}
    inc src
)
include_directories(${INC})

file(GLOB INI
    RELATIVE ${CMAKE_SOURCE_DIR} CONFIGURE_DEPENDS
    lib/*.ini lib/*.f
)
"
    ()

let syntax () =
  Sys.command "cp ~/em/cmake/FindRAGEL.cmake cmake/" |> ignore;
  Sys.command "cp ~/em/cmake/FindREADLINE.cmake cmake/" |> ignore;
  touch "cmake/syntax.cmake" ~c:"\
find_package(FLEX     REQUIRED)
find_package(BISON    REQUIRED)
find_package(RAGEL    REQUIRED)
find_package(READLINE REQUIRED)

file(GLOB X
    RELATIVE ${CMAKE_SOURCE_DIR}
    src/*.lex
)

file(GLOB Y
    RELATIVE ${CMAKE_SOURCE_DIR}
    src/*.yacc
)

file(GLOB R
    RELATIVE ${CMAKE_SOURCE_DIR}
    src/*.ragel
)

foreach(LEX_FILE ${X})
    string(REGEX REPLACE \".+\\/(.+)\\.lex$\" \"${CMAKE_BINARY_DIR}/\\\\1.lex.cpp\"
        LEXER_CPP           ${LEX_FILE})
        list(APPEND CP      ${LEXER_CPP})
    string(REGEX REPLACE \".+\\/(.+)\\.lex$\" \"${CMAKE_BINARY_DIR}/\\\\1.lex.hpp\"
        LEXER_HPP           ${LEX_FILE})
        list(APPEND HP      ${LEXER_HPP})
    add_custom_command(
        OUTPUT              ${LEXER_CPP} ${LEXER_HPP}
        DEPENDS             ${LEX_FILE}
        WORKING_DIRECTORY   ${CMAKE_SOURCE_DIR}
        COMMAND             ${FLEX_EXECUTABLE}
        ARGS                --header-file=${LEXER_HPP} -o ${LEXER_CPP} ${LEX_FILE}
    )
endforeach()
"
    ()

let cmake () =
  mkd "cmake" ();
  Sys.command "cp ~/em/cmake/x86_64-linux-gnu.cmake cmake/" |> ignore;
  Sys.command "cp ~/em/cmake/any_toolchain.cmake cmake/" |> ignore;
  Sys.command "cp ~/em/cmake/version.cmake cmake/" |> ignore;
  Sys.command "cp ~/em/cmake/instal.cmake cmake/" |> ignore;
  Sys.command "cp ~/em/cmake/clean.cmake cmake/" |> ignore;
  src ();
  syntax ();
  cMakeLists ();
  cMakePresets ()

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
"
    ()

let main () =
  touch "inc/main.hpp"
    ~c:
      "#pragma once

extern int main(int argc, char *argv[]);
extern void arg(int argc, char *argv);
"
    ();
  touch "src/main.cpp"
    ~c:
      "#include \"app.hpp\"

int main(int argc, char *argv[]) {
    arg(0, argv[0]);
    for (int i = 1; i < argc; i++) {  //
        arg(i, argv[i]);
    }
    return 0;
}

void arg(int argc, char *argv) {  //
    std::clog << \"arg[\" << argc << \"] = <\" << argv << \"]\\n\";
}
"
    ()

let hpp () =
  mkd "inc" ();
  libc ();
  touch [%string "inc/app.hpp"]
    ~c:"#pragma once

#include \"libc.hpp\"
#include \"main.hpp\"
" ()

let cpp () =
  mkd "src" ();
  touch [%string "src/%{app}.cpp"] ~c:[%string "#include \"app.hpp\"
"] ()

let doxygen () =
  Sys.command "doxygen -l" |> ignore;
  Sys.command "mv DoxygenLayout.xml doc/" |> ignore;
  touch ".doxygen"
    ~c:
      [%string
        "PROJECT_NAME           = \"%{app}\"
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

let cf () = Sys.command "cp ~/em/.clang-format ./" |> ignore

let c_cpp_properties () =
  touch ".vscode/c_cpp_properties.json"
    ~c:
      "{
    \"version\": 4,
    \"configurations\": [
        {
            \"name\"                  : \"linux\",
            \"configurationProvider\" : \"ms-vscode.cmake-tools\",
            \"mergeConfigurations\"   : true
        }
    ]
}
"
    ()

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

let aptcpp () =
  let c =
    {|
g++ cmake clang-format doxygen
gdb valgrind cgroup-tools
flex bison ragel libreadline-dev
|}
  in
  append "apt.Debian" ~c:[%string "code meld%{c}"] ();
  append "apt.Ubuntu" ~c ();
  append "apt.Raspbian" ~c ()

let cpp () =
  mkd "src" ();
  hpp ();
  cpp ();
  main ();
  cmake ();
  doxygen ();
  cf ();
  c_cpp_properties ();
  aptcpp ();
  cpplaunch ()
