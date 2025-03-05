%{
    #include "parser.hpp"
    char *yyfile = nullptr;
%}

%option yylineno noyywrap

s [+\-]
n [0-9]

%%
#[^\n]*         {}                  // line comment
[ \t\r\n]+      {}                  // drop spaces

{s}?{n}+\.{n}+  TOKEN(Num,NUM)      // float
0x[0-9a-fA-F]+  TOKEN(Hex,INT)      // hexadecimal
{s}?{n}+        TOKEN(Int,INT)      // integer

.               {yyerror("lex");}   // any undetected char
