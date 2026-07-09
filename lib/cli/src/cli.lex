%{
    #include "cli.hpp"
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
"#!"[^\n]+              {}                          // shebang
"#"[^\n]*               {}                          // line comment

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

0x[_0-9a-fA-F]+         {yylval.n = hex(yytext); return t_HEX;}   // hexadecimal
0o[_0-7]+               {yylval.n = oct(yytext); return t_OCT;}   // octal
0b[_01]+                {yylval.n = bin(yytext); return t_BIN;}   // binary

":"                     {return COLON;}

"nop"                   {yylval.b = (byte)Op::nop ; return CMD0;}
"halt"                  {yylval.b = (byte)Op::halt; return CMD0;}

"blit"                  {yylval.b = (byte)Op::blit; return CMDb;}
"alit"                  {yylval.b = (byte)Op::alit; return CMDa;}
"clit"                  {yylval.b = (byte)Op::clit; return CMDc;}

{s}?[_0-9]+             {yylval.n = dec(yytext); return INT;}   // integer

{alpha}{alnum}*         { yylval.s = new std::string(yytext); return ID;  }

[ \t\r\n]+              {}                          // drop spaces
.                       {yyerror("");}              // any undetected char
