%{
    #include "cli.hpp"
    char *yyfile = nullptr;
%}

%option noyywrap yylineno

s [+\-]
n [0-9]

/* special states for block comments */
%x STACK

%%
"#!"[^\n]+  {}                                      // shebang
"//"[^\n]+  {}                                      // line comment
[ \t\r\n]+  {}                                      // drop spaces

"("         {BEGIN(STACK  );}                       // start stack notation
<STACK>")"  {BEGIN(INITIAL);}                       // end stack notation
<STACK>.    {}                                      // ignore any chars

{s}?{n}+[eE]{s}?{n}+    {yylval.f = num(yytext); return NUM;}   // float
{s}?{n}+\.{n}+          {yylval.f = num(yytext); return NUM;}   // float
{s}?{n}+                {yylval.n = dec(yytext); return INT;}   // integer
0x[0-9a-fA-F]+          {yylval.n = hex(yytext); return HEX;}   // hexadecimal
0o[0-7]+                {yylval.n = oct(yytext); return OCT;}   // octal
0b[01]+                 {yylval.n = bin(yytext); return BIN;}   // binary

.           {yyerror("");}                          // any undetected char
