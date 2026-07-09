find_package(FLEX     REQUIRED)
find_package(BISON    REQUIRED)
find_package(RAGEL    REQUIRED)
find_package(READLINE REQUIRED)

file(GLOB_RECURSE X CONFIGURE_DEPENDS src/*.l* lib/**/*.l* )
file(GLOB_RECURSE Y CONFIGURE_DEPENDS src/*.y* lib/**/*.y* )
file(GLOB_RECURSE R CONFIGURE_DEPENDS src/*.r* lib/**/*.r* )

foreach(lex ${X})
    get_filename_component(name ${lex} NAME_WE)
    set(cpp "${CMAKE_CURRENT_BINARY_DIR}/${name}.lex.cpp")
    set(hpp "${CMAKE_CURRENT_BINARY_DIR}/${name}.lex.hpp")
    list(APPEND CP ${cpp})
    list(APPEND HP ${hpp})
    add_custom_command(
        OUTPUT  ${cpp} ${hpp}
        DEPENDS ${lex}
        COMMAND ${FLEX_EXECUTABLE} -o${cpp} --header-file=${hpp} ${lex}
    )
endforeach()

foreach(yacc ${Y})
    get_filename_component(name ${yacc} NAME_WE)
    set(cpp "${CMAKE_CURRENT_BINARY_DIR}/${name}.yacc.cpp")
    set(hpp "${CMAKE_CURRENT_BINARY_DIR}/${name}.yacc.hpp")
    list(APPEND CP ${cpp})
    list(APPEND HP ${hpp})
    add_custom_command(
        OUTPUT  ${cpp} ${hpp}
        DEPENDS ${yacc}
        COMMAND ${BISON_EXECUTABLE} -o${cpp} ${yacc}
    )
endforeach()

foreach(ragel ${R})
    get_filename_component(name ${ragel} NAME_WE)
    set(cpp "${CMAKE_CURRENT_BINARY_DIR}/${name}.ragel.cpp")
    set(hpp "${CMAKE_CURRENT_BINARY_DIR}/${name}.ragel.hpp")
    list(APPEND CP ${cpp})
    list(APPEND HP ${hpp})
    add_custom_command(
        OUTPUT  ${cpp} ${hpp}
        DEPENDS ${ragel}
        COMMAND ${RAGEL_EXECUTABLE} -C -G2 -o ${cpp} ${ragel}
    )
endforeach()

find_program( LEMON_EXECUTABLE lemon   )
find_program(BINPAC_EXECUTABLE binpac  )

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
