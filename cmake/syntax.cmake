find_package(RAGEL REQUIRED)
find_package(FLEX  REQUIRED)
find_package(BISON REQUIRED)

# file(GLOB L CONFIGURE_DEPENDS ${SRC}/*.lex)
# file(GLOB Y CONFIGURE_DEPENDS ${SRC}/*.yacc)
# get_filename_component(lex  ${L} NAME_WE)
# get_filename_component(yacc ${Y} NAME_WE)
#  FLEX_TARGET(lex  ${L} ${TMP}/${lex}.lexer.cpp)
# BISON_TARGET(yacc ${Y} ${TMP}/${yacc}.parser.cpp
#           DEFINES_FILE ${TMP}/${yacc}.parser.hpp)
