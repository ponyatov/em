%{
    #include "cli.hpp"
%}

%defines %union { int n; float f; }

%token<n> INT HEX OCT BIN
%token<f> NUM
%%
syntax: | syntax ex

ex: NUM     { fprintf(stderr,"num:%e\n",$1); }
  | INT     { fprintf(stderr,"num:%i\n",$1); }
  | HEX     { fprintf(stderr,"hex:%x\n",$1); }
  | OCT     { fprintf(stderr,"oct:%o\n",$1); }
  | BIN     { fprintf(stderr,"bin:%b\n",$1); }
