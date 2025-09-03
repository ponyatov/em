%{
    #include "cli.hpp"
%}

%defines %union { char c; char* s; int n; float f; }

%token<n> INT HEX OCT BIN
%token<f> NUM
%%
syntax: | syntax ex

ex: NUM     { fprintf(stderr,"num:%e\n",$1); }
  | INT     { fprintf(stderr,"num:%i\n",$1); }
  | HEX     { fprintf(stderr,"hex:%x\n",$1); }
  | OCT     { fprintf(stderr,"oct:%o\n",$1); }
  | BIN     { fprintf(stderr,"bin:%b\n",$1); }

%%
void yyerror(const char *msg) {
    fprintf(stderr, "\n\n%s:%i %s [%s]\n\n", yyfile, yylineno, msg, yytext);
    exit(-1);
}
