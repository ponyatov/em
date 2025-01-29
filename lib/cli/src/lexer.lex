%{
#include "app.hpp"
char *yyfile = nullptr;
%}

%option noyywrap yylineno

s [+\-]
n [0-9]

%%
#[^\n]*     {}  // line comment
[ \t\r\n]+  {}  // drop spaces

"0x"[0-9a-fA-F]+        TOKEN(Hex,INT)
"0o"[0-7]+              TOKEN(Oct,INT)
"0b"[01]+               TOKEN(Bin,INT)
{s}?{n}+\.{n}+          TOKEN(Int,FLOAT)
{s}?{n}+[eE]{s}?{n}+    TOKEN(Int,FLOAT)
{s}?{n}+                TOKEN(Int,INT)

.           {yyerror("");}  // any undetected char
