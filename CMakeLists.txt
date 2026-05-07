cmake_minimum_required(VERSION 3.25)
get_filename_component(CMAKE_PROJECT_NAME ${CMAKE_SOURCE_DIR} NAME)
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
project(${CMAKE_PROJECT_NAME} VERSION 0.0.1 LANGUAGES CXX C ASM)

include(version)  # binary files naming by version & git branch/hash
include(src)      # scan project for source code files
include(syntax)   # parser generators (flex,yacc/bison,ragel,..)
include(qt)       # portable GUI
include(net)      # raw packets networking

include(erlang)   # Erlang jigs
include(wasm)     # WebAssembly WASI runtime
include(kaitai)   # binary parsers
include(kmod)     # Linux kernel module

message("-- |")
message("-- | toolchain: " ${CMAKE_CXX_COMPILER} " @ " ${CMAKE_TOOLCHAIN_FILE})
message("-- |      host: " ${CMAKE_HOST_SYSTEM_NAME}-${CMAKE_HOST_SYSTEM_VERSION})
message("-- |    target: " "hw:" ${HW} " cpu:" ${CPU} " arch:" ${ARCH} " os:" ${OS})
message("-- |   startup: " "${S}")
message("-- |    linker: " "${LD}")
message("-- |    binary: " "${CMAKE_INSTALL_PREFIX}/${BIN_OUTPUT_NAME}${CMAKE_EXECUTABLE_SUFFIX}")
message("-- |       ini: " "${F}")
message("-- |      data: " "${DATA}")
message("-- |       cpp: " "${C} ${CP}")
message("-- |       hpp: " "${H} ${HP}")
message("-- |")

include(json2cpp)
include(gen2obj)

add_executable(${CMAKE_PROJECT_NAME}
    ${C}  ${H}          # C/C++ sources
    ${CP} ${HP}         # generated parsers
    ${S}  ${LD}         # embedded/lowlevel
    ${F}                # init/config files & scripts
    ${Q}                # Qt Designer sources
    ${DATA}             # precompiled binary data (bytecode,..)
    ${KMOD}             # Linux kernel module
)

target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE ${INC})

set_source_files_properties(${F} PROPERTIES HEADER_FILE_ONLY TRUE)

target_link_directories(${CMAKE_PROJECT_NAME} PRIVATE)

target_link_libraries(${CMAKE_PROJECT_NAME}
    -Wl,--start-group ${L} -Wl,--end-group
) # -static

include(install) # target install
include(clean)   # project clean-up (remove generated & temp files)
include(fw)      # cross compiler binaries: elf/dfu
