

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

let cppmin () =
let hpp () =
  touch ("inc/"^app^".hpp") ~c:("#pragma once


") ();

let cpp () =
    touch ("src/"^app^".cpp") ~c:("#include \""^app^".hpp\"\nint main() {}\n") ();

let lists () =
  touch "CMakeLists.txt" ~c:("cmake_minimum_required(VERSION 3.25)
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
message(\"-- |      data: \" \"${DATA} ${WASM}\")
message(\"-- |       ini: \" \"${INI}\")
message(\"-- |\")

add_executable(${CMAKE_PROJECT_NAME}
    ${C}  ${H}          # C/C++ source
    ${S}  ${LD}         # embedded/lowlevel
    ${CP} ${HP}         # parsers
    ${INI}              # init/config files & scripts
)

set_source_files_properties(${INI} PROPERTIES HEADER_FILE_ONLY TRUE)

target_link_directories(${CMAKE_PROJECT_NAME} PRIVATE)

target_link_libraries(${CMAKE_PROJECT_NAME}
    -Wl,--start-group ${L} -Wl,--end-group
) # -static

include(install) # target install
include(clean)   # project clean-up (remove generated & temp files)
") ();

let presets () =
    touch "CMakePresets.json" ~c:("{
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
") ()
  
let cmake () =
  mkdir "cmake" ();
  lists (); presets();
  Sys.command "git add CMake* cmake"

let aptcpp () =
  let c = "g++ cmake pkg-config clang-format doxygen
gdb gdbserver valgrind cgroup-tools
flex bison ragel libreadline-dev
" in
  append "apt.Debian" ~c:("code meld\n"^c) ();
  append "apt.Ubuntu" ~c:(""^c) ();
  append "apt.Raspbian" ~c:(""^c) ();
  Sys.command "git add apt.*"

let cf () =
  Sys.command "cp ~/em/.clang-format ./" |> ignore;
  Sys.command "git add .clang-format"|> ignore;

let cpplaunch () =
    touch ".vscode/launch.json"
      ~c:"{
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
  
let cpp () =
  mkd "inc" (); mkd "src" ();
  hpp ()l; cpp(); cmake ();
  doxygen (); aptcpp () ; cf ();
  cpplaunch ()
    
(* let main () =
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
  Sys.command "git add doc inc src" *)
