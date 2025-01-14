cmake_minimum_required(VERSION 3.22)
get_filename_component(CMAKE_PROJECT_NAME ${CMAKE_SOURCE_DIR} NAME_WE)
project(${CMAKE_PROJECT_NAME} LANGUAGES C CXX ASM)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_SOURCE_DIR}/cmake)
include(version)

set(CWD ${CMAKE_SOURCE_DIR})
set(BIN ${CWD}/bin)
set(DOC ${CWD}/doc)
set(LIB ${CWD}/lib)
set(INC ${CWD}/inc)
set(SRC ${CWD}/src)
set(TMP ${CWD}/tmp)

file(GLOB_RECURSE LD
    "${CWD}/hw/${HW}/*.ld"
)
file(GLOB_RECURSE A
    "${CWD}/src/*.s*"
    "${CWD}/hw/${HW}/src/*.s"
    "${CWD}/cpu/${CPU}/src/*.s"
    "${CWD}/arch/${ARCH}/src/*.s"
    "${CWD}/os/${OS}/src/*.s"
)
file(GLOB_RECURSE C
    "${CWD}/src/*.c*"
    "${CWD}/hw/${HW}/src/*.c*"
    "${CWD}/cpu/${CPU}/src/*.c*"
    "${CWD}/arch/${ARCH}/src/*.c*"
    "${CWD}/os/${OS}/src/*.c*"
)
file(GLOB_RECURSE H
    "${CWD}/inc/*.h*"
    "${CWD}/hw/${HW}/inc/*.h*"
    "${CWD}/cpu/${CPU}/inc/*.h*"
    "${CWD}/arch/${ARCH}/inc/*.h*"
    "${CWD}/os/${OS}/inc/*.h*"
)

include_directories(
    ${INC} ${TMP} ${SRC}
    "${CWD}/hw/${HW}/inc"
    "${CWD}/cpu/${CPU}/inc"
    "${CWD}/arch/${ARCH}/inc"
    "${CWD}/os/${OS}/inc"
)

message("-- toolchain: " ${CMAKE_CXX_COMPILER} " @ " ${CMAKE_TOOLCHAIN_FILE})
message("--    target: " "hw:" ${HW} " cpu:" ${CPU} " arch:" ${ARCH})
message("--        os: " ${OS})
message("--   startup: " ${A})
message("--    binary: " ${BIN_OUTPUT_NAME})

add_executable(${CMAKE_PROJECT_NAME}
    ${C} ${H} ${A} ${LD}
    ${FLEX_lex_OUTPUTS} ${BISON_yacc_OUTPUTS}
)

target_link_libraries(${CMAKE_PROJECT_NAME})

set_target_properties(${CMAKE_PROJECT_NAME} PROPERTIES OUTPUT_NAME ${BIN_OUTPUT_NAME})
install(TARGETS ${CMAKE_PROJECT_NAME} DESTINATION ${CMAKE_INSTALL_PREFIX})
