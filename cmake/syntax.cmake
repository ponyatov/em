# parser generators (flex,yacc/bison,ragel,lemon,..)

find_package(FLEX              REQUIRED)
find_package(BISON             REQUIRED)
find_program( RAGEL_EXECUTABLE ragel   )
find_program( LEMON_EXECUTABLE lemon   )
find_program(BINPAC_EXECUTABLE binpac  )
# find_package(Readline REQUIRED)

file(GLOB L
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

file(GLOB M
    RELATIVE ${CMAKE_SOURCE_DIR}
    src/*.lemon
    lib/src/*.lemon lib/*/src/*.lemon
)

file(GLOB B
    RELATIVE ${CMAKE_SOURCE_DIR}
    src/*.binpac
    lib/src/*.binpac lib/*/src/*.binpac
)

foreach(LEX_FILE ${L})
    string(REGEX REPLACE ".+\/(.+)\.lex$" "${CMAKE_BINARY_DIR}/\\1.lex.cpp"
        LEXER_CPP           ${LEX_FILE})
        list(APPEND CP      ${LEXER_CPP})
    string(REGEX REPLACE ".+\/(.+)\.lex$" "${CMAKE_BINARY_DIR}/\\1.lex.hpp"
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
    string(REGEX REPLACE ".+\/(.+)\.yacc$" "${CMAKE_BINARY_DIR}/\\1.yacc.cpp"
        PARSER_CPP          ${YACC_FILE})
    string(REGEX REPLACE ".+\/(.+)\.yacc$" "${CMAKE_BINARY_DIR}/\\1.yacc.hpp"
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

if(RAGEL_EXECUTABLE)
    foreach(RAGEL_FILE ${R})
        string(REGEX REPLACE ".+\/(.+)\.ragel$" "${CMAKE_BINARY_DIR}/\\1.ragel.cpp"
            RAGEL_CPP           ${RAGEL_FILE})
        list(APPEND CP          ${RAGEL_CPP})
        add_custom_command(
            OUTPUT              ${RAGEL_CPP}
            DEPENDS             ${RAGEL_FILE}
            WORKING_DIRECTORY   ${CMAKE_SOURCE_DIR}
            COMMAND             ${RAGEL_EXECUTABLE}
            ARGS                -C -G2 -o ${RAGEL_CPP} ${RAGEL_FILE}
        )
    endforeach()
endif()

if(LEMON_EXECUTABLE)
    foreach(LEMON_FILE ${M})
        #
        string(REGEX REPLACE ".+\/(.+)\.lemon$" "${CMAKE_BINARY_DIR}/\\1.lemon.cpp"
            LEMON_CPP           ${LEMON_FILE})
        list(APPEND CP          ${LEMON_CPP})
        string(REGEX REPLACE ".+\/(.+)\.lemon$" "${CMAKE_BINARY_DIR}/\\1.lemon.hpp"
            LEMON_HPP           ${LEMON_FILE})
        list(APPEND HP          ${LEMON_HPP})
        string(REGEX REPLACE ".+\/(.+)\.lemon$" "${CMAKE_BINARY_DIR}/\\1.lemon.out"
            LEMON_OUT           ${LEMON_FILE})
        list(APPEND OP          ${LEMON_OUT})
        #
        string(REGEX REPLACE ".+\/(.+)\.lemon$" "${CMAKE_BINARY_DIR}/\\1.c"
            LEMON_C             ${LEMON_FILE})
        string(REGEX REPLACE ".+\/(.+)\.lemon$" "${CMAKE_BINARY_DIR}/\\1.h"
            LEMON_H             ${LEMON_FILE})
        string(REGEX REPLACE ".+\/(.+)\.lemon$" "${CMAKE_BINARY_DIR}/\\1.out"
            LEMON_O             ${LEMON_FILE})
        add_custom_command(
            OUTPUT              ${LEMON_C} ${LEMON_H} ${LEMON_O}
            DEPENDS             ${LEMON_FILE}
            WORKING_DIRECTORY   ${CMAKE_SOURCE_DIR}
            COMMAND             ${LEMON_EXECUTABLE}
            ARGS                -l -d${CMAKE_BINARY_DIR} ${LEMON_FILE}
        )
        add_custom_command(
            OUTPUT              ${LEMON_CPP}
            DEPENDS             ${LEMON_C}
            WORKING_DIRECTORY   ${CMAKE_SOURCE_DIR}
            COMMAND             mv
            ARGS                ${LEMON_C} ${LEMON_CPP}
        )
        add_custom_command(
            OUTPUT              ${LEMON_HPP}
            DEPENDS             ${LEMON_H}
            WORKING_DIRECTORY   ${CMAKE_SOURCE_DIR}
            COMMAND             mv
            ARGS                ${LEMON_H} ${LEMON_HPP}
        )
        add_custom_command(
            OUTPUT              ${LEMON_OUT}
            DEPENDS             ${LEMON_O}
            WORKING_DIRECTORY   ${CMAKE_SOURCE_DIR}
            COMMAND             mv
            ARGS                ${LEMON_O} ${LEMON_OUT}
        )
    endforeach()
endif()

if(BINPAC_EXECUTABLE)
    foreach(BINPAC_FILE ${B})
        string(REGEX REPLACE ".+\/(.+)\.binpac$" "\\1.binpac_pac.cc"
            BINPAC_CC           ${BINPAC_FILE})
        string(REGEX REPLACE ".+\/(.+)\.binpac$" "\\1.binpac_pac.h"
            BINPAC_H            ${BINPAC_FILE})
        list(APPEND CP          ${BINPAC_CC})
        list(APPEND HP          ${BINPAC_H})
        add_custom_command(
            OUTPUT              ${BINPAC_CC} ${BINPAC_H}
            DEPENDS             ${BINPAC_FILE}
            WORKING_DIRECTORY   ${CMAKE_BINARY_DIR}
            COMMAND             ${BINPAC_EXECUTABLE} -d ${CMAKE_BINARY_DIR} && touch binpac.pac
            ARGS                ${CMAKE_SOURCE_DIR}/${BINPAC_FILE}
        )
    endforeach()
endif()
