<<<<<<< HEAD

let cMakeLists () = touch "CMakeLists.txt" ()
let cMakePresets () = touch "CMakePresets.json" ()

let install () =
  touch "cmake/install.cmake" ~c:"set_target_properties(${CMAKE_PROJECT_NAME}
=======
let cMakeLists () =
  (* *)
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
message(\"-- |      data: \" \"${DATA} ${WASM}\")
message(\"-- |       ini: \" \"${INI}\")
message(\"-- |\")

add_executable(${CMAKE_PROJECT_NAME}
    ${C}  ${H}          # C/C++ source
    ${S}  ${LD}         # embedded/lowlevel
    ${CP} ${HP}         # parsers
    ${DATA} ${WASM}     # precompiled binary data (bytecode,..)
    ${INI}              # init/config files & scripts
)

set_source_files_properties(${INI} PROPERTIES HEADER_FILE_ONLY TRUE)

target_link_directories(${CMAKE_PROJECT_NAME} PRIVATE)

target_link_libraries(${CMAKE_PROJECT_NAME}
    -Wl,--start-group ${L} -Wl,--end-group
) # -static

include(install) # target install
include(clean)   # project clean-up (remove generated & temp files)
"
    ()

let cMakePresets () =
  (* *)
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

let install () =
  touch "cmake/install.cmake"
    ~c:
      "set_target_properties(${CMAKE_PROJECT_NAME}
>>>>>>> ebc2351d16f8ac53c3e45a30e4e3ceef0045b36d
    PROPERTIES OUTPUT_NAME ${BIN_OUTPUT_NAME}${CMAKE_EXECUTABLE_SUFFIX})
install(TARGETS ${CMAKE_PROJECT_NAME}
    DESTINATION ${CMAKE_INSTALL_PREFIX})
file(CREATE_LINK ${BIN_OUTPUT_NAME}${CMAKE_EXECUTABLE_SUFFIX}
    ${CMAKE_INSTALL_PREFIX}/${CMAKE_PROJECT_NAME} SYMBOLIC)
<<<<<<< HEAD
" ()

let src () =
  touch "cmake/src.cmake" ()

let cmake () =
  cMakeLists ();
  cMakePresets ();
  mkd "cmake" ();
  Sys.command "cp ~/em/cmake/x86_64-linux-gnu.cmake cmake/";
  Sys.command "cp ~/em/cmake/any_toolchain.cmake cmake/";
  Sys.command "cp ~/em/cmake/cross.cmake cmake/";
  Sys.command "cp ~/em/cmake/version.cmake cmake/";
  src()
  install ()
=======
"
    ()

let src () =
  (* *)
  touch "cmake/src.cmake"
    ~c:
      "# file(GLOB LD -> cmake/any_toolchain.cmake

file(GLOB S
    RELATIVE ${CMAKE_SOURCE_DIR}
    src/*.s
)

file(GLOB C
    RELATIVE ${CMAKE_SOURCE_DIR}
    src/*.c*
)

file(GLOB H
    RELATIVE ${CMAKE_SOURCE_DIR}
    inc/*.h*
)

file(GLOB INC
    RELATIVE ${CMAKE_SOURCE_DIR}
    ${CMAKE_BINARY_DIR}
    inc src
)
include_directories(${INC})

file(GLOB INI
    RELATIVE ${CMAKE_SOURCE_DIR}
    lib/*.ini lib/*.f
)
"
    ()

let syntax () =
  touch "cmake/syntax.cmake"
    ~c:
      "find_package(FLEX     REQUIRED)
find_package(BISON    REQUIRED)
# find_program(RAGEL    REQUIRED)
find_package(READLINE REQUIRED)

file(GLOB X
    RELATIVE ${CMAKE_SOURCE_DIR}
    src/*.lex
    lib/src/*.lex lib/*/src/*.lex
)

file(GLOB Y
    RELATIVE ${CMAKE_SOURCE_DIR}
    src/*.yacc
    lib/src/*.yacc lib/*/src/*.yacc
)

file(GLOB R
    RELATIVE ${CMAKE_SOURCE_DIR}
    src/*.ragel
    lib/src/*.ragel lib/*/src/*.ragel
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

foreach(YACC_FILE ${Y})
    string(REGEX REPLACE \".+\\/(.+)\\.yacc$\" \"${CMAKE_BINARY_DIR}/\\\\1.yacc.cpp\"
        PARSER_CPP          ${YACC_FILE})
    string(REGEX REPLACE \".+\\/(.+)\\.yacc$\" \"${CMAKE_BINARY_DIR}/\\\\1.yacc.hpp\"
        PARSER_HPP          ${YACC_FILE})
    list(APPEND CP          ${PARSER_CPP})
    list(APPEND HP          ${PARSER_HPP})
    add_custom_command(
        OUTPUT              ${PARSER_CPP} ${PARSER_HPP}
        DEPENDS             ${YACC_FILE}
        WORKING_DIRECTORY   ${CMAKE_SOURCE_DIR}
        COMMAND             ${BISON_EXECUTABLE}
        ARGS                -o ${PARSER_CPP} ${YACC_FILE}
    )
endforeach()

foreach(RAGEL_FILE ${R})
    string(REGEX REPLACE \".+\/(.+)\.ragel$\" \"${CMAKE_BINARY_DIR}/\\\\1.ragel.cpp\"
        RAGEL_CPP           ${RAGEL_FILE})
    list(APPEND CP          ${RAGEL_CPP})
    add_custom_command(
        OUTPUT              ${RAGEL_CPP}
        DEPENDS             ${RAGEL_FILE}
        WORKING_DIRECTORY   ${CMAKE_SOURCE_DIR}
        COMMAND             ragel
        ARGS                -C -G2 -o ${RAGEL_CPP} ${RAGEL_FILE}
    )
endforeach()

add_compile_definitions(YYSTYPE=cell)
"
    ()

let cmake () =
  mkd "cmake" ();
  cMakeLists ();
  cMakePresets ();
  Sys.command "cp ~/em/cmake/x86_64-linux-gnu.cmake cmake/" |> ignore;
  Sys.command "cp ~/em/cmake/any_toolchain.cmake cmake/" |> ignore;
  Sys.command "cp ~/em/cmake/version.cmake cmake/" |> ignore;
  Sys.command "cp ~/em/cmake/clean.cmake cmake/" |> ignore;
  Sys.command "cp ~/em/cmake/FindRAGEL.cmake cmake/" |> ignore;
  Sys.command "cp ~/em/cmake/FindREADLINE.cmake cmake/" |> ignore;
  src ();
  install ();
  syntax ();
  Sys.command "git add CMake* cmake"
>>>>>>> ebc2351d16f8ac53c3e45a30e4e3ceef0045b36d
