find_package(FLEX  REQUIRED)
find_package(BISON REQUIRED)
find_package(RAGEL REQUIRED)

foreach(LEX_FILE ${L})
    string(REGEX REPLACE ".+\/(.+)\.lex$" "${CMAKE_BINARY_DIR}/\\1.lex.cpp"
        LEXER_CPP           ${LEX_FILE})
    list(APPEND CP          ${LEXER_CPP})
    add_custom_command(
        OUTPUT              ${LEXER_CPP}
        DEPENDS             ${LEX_FILE}
        WORKING_DIRECTORY   ${CMAKE_SOURCE_DIR}
        COMMAND             ${FLEX_EXECUTABLE}
        ARGS                -o ${LEXER_CPP} ${LEX_FILE}
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
