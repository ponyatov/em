%{
    #include "cli.hpp"
    char *yyfile = nullptr;
    #define YY_DO_BEFORE_ACTION {}
    #define YY_NEW_FILE {}
    bool yywrap() { return true; }
%}

%option noyywrap yylineno

sign  [+\-]
digit [0-9]
alpha [a-zA-Z_]
alnum [a-zA-Z_0-9]

/* special states for block comments */
%x STACK COMMENT

%%
"#!"[^\n]+              {}                              // shebang
"//"[^\n]+              {}                              // line comment

"/*"                    {BEGIN(COMMENT);}               // start block comment
<COMMENT>"*/"           {BEGIN(INITIAL);}               // end stack notation
<COMMENT>.              {}                              // ignore any chars

"("                     {BEGIN(STACK  );}               // start stack notation
<STACK>")"              {BEGIN(INITIAL);}               // end stack notation
<STACK>.                {}                              // ignore any chars

{s}?{n}+[eE]{s}?{n}+    {yylval.f = num(yytext); return NUM;}   // float
{s}?{n}+\.{n}+          {yylval.f = num(yytext); return NUM;}   // float
{s}?{n}+                {yylval.n = dec(yytext); return INT;}   // integer
0x[0-9a-fA-F]+          {yylval.n = hex(yytext); return HEX;}   // hexadecimal
0o[0-7]+                {yylval.n = oct(yytext); return OCT;}   // octal
0b[01]+                 {yylval.n = bin(yytext); return BIN;}   // binary

":"                     {return COLON;}

({alnum}+\/)*{alnum}+\.ini  { yylval.s = new std::string(yytext); return INI; }
{alpha}{alnum}*             { yylval.s = new std::string(yytext); return ID;  }

[ \t\r\n]+              {}                              // drop spaces
.                       {yyerror("");}                  // any undetected char
