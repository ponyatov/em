let lex () =
  (* *)
  touch "src/cli.lex" ~c:"%{
    #include \"app.hpp\"
%}

%option noyywrap yylineno

s [+\\-]
n [0-9]
%%
#[^\\n]*         {}              // line comment
[ \\t\\r\\n]+      {}              // drop spaces

{s}?{n}+        {yylval.n = atoi(yytext); return INT;}

.               {yyerror(\"\");}  // any undetected char
" ()

let yacc () =
  (* *)
  touch "src/cli.yacc"
    ~c:
      "%{\n    #include \"app.hpp\"\n%}

%defines %union { int n ; float f ; char c; std::string* s; }

%token<n> INT
%token<f> NUM

%%
syntax:|syntax ex

ex  : INT   { std::clog << \"int:\" << $1 << \"\\n\"; }
    | NUM   { std::clog << \"num:\" << $1 << \"\\n\"; }
"
    ()

let cli_hpp () =
  touch "inc/cli.hpp"
    ~c:
      "#pragma once
/// @defgroup syntax syntax
/// @ingroup command/syntax parser
/// @{

/// @name lexer
/// @{
extern int yylex();        ///< lexer (`flex`)
extern int yylineno;       ///< line number
extern char *yytext;       ///< lexeme (token) string value
extern char *yyfile;       ///< current file name
extern std::string yystr;  ///< buffer for block lexing (string, comment,..)
extern FILE *yyin;         ///< script file handler
/// @}

/// @name parser
/// @{
extern void parse(char *);             ///< parse string
extern int yyparse();                  ///< parser (`bison`)
extern void yyerror(std::string msg);  ///< syntax error callback
#include \"cli.yacc.hpp\"
/// @}
"
    ()

let cli_cpp () = 
  touch "src/cli.cpp" ~c:"#include \"app.hpp\"

std::string yystr;
char *yyfile = nullptr;

void yyerror(std::string msg) {                              //
    std::cerr << \"\\n\\nerror: \" << yyfile << ':' << yylineno  //
              << ' ' << msg << \" [\" << yytext << \"]\\n\\n\";
    exit(-1);
}

void setup(int argc, char* argv[]) {
    std::clog << \"setup:\\n\";
    arg(0, argv[0]);
    for (int i = 1; i < argc; i++) {
        arg(i, argv[i]);
        yyfile = argv[i];
        assert(yyin = fopen(yyfile, \"r\"));
        yyparse();
        fclose(yyin);
        yyfile = nullptr;
    }
}
" ()

let syntax () =
  lex ();
  yacc ();
  cli_hpp ();
  cli_cpp ()
