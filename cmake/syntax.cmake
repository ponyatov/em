find_package(RAGEL REQUIRED)
find_package(FLEX  REQUIRED)
find_package(BISON REQUIRED)

set(RAGEL_EXECUTABLE_opts -C -G2 )

file(GLOB RL
    RELATIVE ${CMAKE_SOURCE_DIR}
    src/*.ragel lib/src/*.ragel lib/*/src/*.ragel
)

file(GLOB L
    RELATIVE ${CMAKE_SOURCE_DIR}
    src/*.lex   lib/src/*.lex   lib/*/src/*.lex
)

file(GLOB Y
    RELATIVE ${CMAKE_SOURCE_DIR}
    src/*.yacc  lib/src/*.yacc  lib/*/src/*.yacc
)

foreach(RAGEL_FILE ${RL})
    string(REGEX REPLACE ".+\/(.+)\.ragel$" "tmp/\\1.ragel.cpp"
                            PARSER_FILE ${RAGEL_FILE})
    list(APPEND CP          ${PARSER_FILE})
    add_custom_command(
        OUTPUT              ${CMAKE_SOURCE_DIR}/${PARSER_FILE}
        DEPENDS             ${RAGEL_FILE}
        WORKING_DIRECTORY   ${CMAKE_SOURCE_DIR}
        COMMAND             ${RAGEL_EXECUTABLE}
        ARGS                ${RAGEL_EXECUTABLE_opts} -o ${PARSER_FILE} ${RAGEL_FILE}
    )
endforeach()

foreach(LEX_FILE ${L})
    string(REGEX REPLACE ".+\/(.+)\.lex$" "tmp/\\1.lex.cpp"
                            PARSER_FILE ${LEX_FILE})
    list(APPEND CP          ${PARSER_FILE})
    add_custom_command(
        OUTPUT              ${CMAKE_SOURCE_DIR}/${PARSER_FILE}
        DEPENDS             ${LEX_FILE}
        WORKING_DIRECTORY   ${CMAKE_SOURCE_DIR}
        COMMAND             ${FLEX_EXECUTABLE}
        ARGS                -o ${PARSER_FILE} ${LEX_FILE}
    )
endforeach()

foreach(YACC_FILE ${Y})
    string(REGEX REPLACE ".+\/(.+)\.yacc$" "tmp/\\1.yacc.cpp"
                            PARSER_FILE ${YACC_FILE})
    list(APPEND CP          ${PARSER_FILE})
    add_custom_command(
        OUTPUT              ${CMAKE_SOURCE_DIR}/${PARSER_FILE}
        DEPENDS             ${YACC_FILE}
        WORKING_DIRECTORY   ${CMAKE_SOURCE_DIR}
        COMMAND             ${BISON_EXECUTABLE}
        ARGS                -o ${PARSER_FILE} ${YACC_FILE}
    )
endforeach()

