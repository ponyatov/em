%{
    #include "bcx.hpp"
    char *yyfile = nullptr;
%}

%option noyywrap yylineno

%%
"#!"[^\n]+  {}              // shebang
"//"[^\n]+  {}              // line comment
[ \t\r\n]+  {}              // drop spaces
.           {yyerror("");}  // any undetected char
