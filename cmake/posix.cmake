# file(GLOB L CONFIGURE_DEPENDS src/*.lex)
# file(GLOB Y CONFIGURE_DEPENDS src/*.yacc)
# get_filename_component(lex  ${L} NAME_WE)
# get_filename_component(yacc ${Y} NAME_WE)
#  FLEX_TARGET(lex  ${L} tmp/${lex}.lexer.cpp)
# BISON_TARGET(yacc ${Y} tmp/${yacc}.parser.cpp
#           DEFINES_FILE tmp/${yacc}.parser.hpp)
