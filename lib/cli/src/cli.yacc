%{
    #include "cli.hpp"
%}

%defines %union { char c; std::string* s; int n; float f; Op op; }

%token<n>  INT HEX OCT BIN
%token<f>  NUM
%token     COLON
%token<s>  ID
%token<op> CMD0 CMD1

%%
syntax: | syntax ex

ex: NUM         { fprintf(stderr,"%.4X: num:%e\n", Cp, $1); compile($1); }
  | INT         { fprintf(stderr,"%.4X: int:%i\n", Cp, $1); compile($1); }
  | HEX         { fprintf(stderr,"%.4X: hex:%x\n", Cp, $1); compile($1); }
  | OCT         { fprintf(stderr,"%.4X: oct:%o\n", Cp, $1); compile($1); }
  | BIN         { fprintf(stderr,"%.4X: bin:%b\n", Cp, $1); compile($1); }
  | COLON ID    { fprintf(stderr,"%.4X: [%s]\n"  , Cp, $2->c_str()); label[*$2] = Cp; }
  | CMD0        { fprintf(stderr,"%.4X: %.2X\n"  , Cp, $1); compile($1); }

%%
void yyerror(const char *msg) {
    fprintf(stderr, "\n\n%s:%i %s [%s]\n\n", yyfile, yylineno, msg, yytext);
    exit(-1);
}
