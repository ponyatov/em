file(GLOB KSY
    RELATIVE ${CMAKE_SOURCE_DIR}
    src/*.ksy
)

set(KSY_RT ${CMAKE_SOURCE_DIR}/ref/kaitai_struct_cpp_stl_runtime)
include_directories(${KSY_RT})

file(GLOB KSY_RT_CPP
    RELATIVE ${CMAKE_SOURCE_DIR}
    ${KSY_RT}/*.cpp
)
list(APPEND CP ${KSY_RT_CPP})

file(GLOB KSY_RT_HPP
    RELATIVE  ${CMAKE_SOURCE_DIR}
    ${KSY_RT}/*.h
)
list(APPEND HP ${KSY_RT_HPP})

foreach(KSY_FILE ${KSY})
    string(REGEX REPLACE ".+\/(.+)\.ksy$" "${CMAKE_BINARY_DIR}/\\1.ksy"
        KSY_PATH            ${KSY_FILE})
    string(REGEX REPLACE ".+\/(.+)\.ksy$" "\\1"
        KSY_NAME            ${KSY_FILE})
    string(REGEX REPLACE ".+\/(.+)\.ksy$" "${KSY_PATH}/\\1.cpp"
        KSY_CPP             ${KSY_FILE})
        list(APPEND CP      ${KSY_CPP})
    string(REGEX REPLACE ".+\/(.+)\.ksy$" "${KSY_PATH}/\\1.h"
        KSY_HPP             ${KSY_FILE})
        list(APPEND HP      ${KSY_HPP})
    add_custom_command(
        OUTPUT              ${KSY_CPP} ${KSY_HPP}
        DEPENDS             ${KSY_FILE} cmake/kaitai.cmake
        WORKING_DIRECTORY   ${CMAKE_SOURCE_DIR}
        COMMAND             kaitai-struct-compiler
        ARGS                -- -I ${CMAKE_SOURCE_DIR}/src -d ${KSY_PATH}
                            -t cpp_stl --cpp-namespace ${KSY_NAME} --cpp-standard 11
                            ${KSY_FILE}
        # $(CMAKE--header-file=${LEXER_HPP} -o ${LEXER_CPP} ${LEX_FILE}
    )
endforeach()
