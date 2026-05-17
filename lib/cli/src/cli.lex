%{
    #include "app.hpp"
    // char *yyfile = nullptr;
    // std::string yystr;
    #define YY_DO_BEFORE_ACTION {}
    #define YY_NEW_FILE {}
    bool yywrap() { return true; }
%}

%option noyywrap yylineno

s  [+\-]
n  [0-9]

alpha [_a-zA-Z]
alnum [_a-zA-Z0-9]

/* block states */
%x STACK COMMENT
%x str

%%
"#!"[^\n]+              {}                              // shebang
"//"[^\n]*              {}                              // line comment

"/*"                    {BEGIN(COMMENT);}               // start block comment
<COMMENT>"*/"           {BEGIN(INITIAL);}               // end stack notation
<COMMENT>.              {}                              // ignore any chars

"("                     {BEGIN(STACK  );}               // start stack notation
<STACK>")"              {BEGIN(INITIAL);}               // end stack notation
<STACK>.                {}                              // ignore any chars

\'                      { BEGIN(str); yystr = ""; }
<str>\'                 { BEGIN(INITIAL);
                          yylval.s = new std::string(yystr); return t_STR; }
<str>\\t                { yystr += '\t';   }
<str>\\r                { yystr += '\r';   }
<str>\\n                { yystr += '\n';   }
<str>.                  { yystr += yytext; }

{s}?{n}+[eE]{s}?{n}+    {yylval.f = num(yytext); return t_NUM;}   // float
{s}?{n}+\.{n}+          {yylval.f = num(yytext); return t_NUM;}   // float
{s}?[_0-9]+             {yylval.n = dec(yytext); return t_INT;}   // integer
0x[_0-9a-fA-F]+         {yylval.n = hex(yytext); return t_HEX;}   // hexadecimal
0o[_0-7]+               {yylval.n = oct(yytext); return t_OCT;}   // octal
0b[_01]+                {yylval.n = bin(yytext); return t_BIN;}   // binary

":"                     {return COLON;}

({alnum}+\/)*{alnum}+\.ini  { yylval.s = new std::string(yytext); return t_INI; }
{alpha}{alnum}*         { yylval.s = new std::string(yytext); return t_ID;  }

[ \t\r\n]+              {}                              // drop spaces
.                       {yyerror(yytext);}              // any undetected char
