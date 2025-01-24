%{
#include "app.hpp"
%}

%defines %union { char c; int n; }

%token <o> INT

%%
syntax: | syntax ex

ex : INT { fprintf(stderr,"int:%i\n",$1); }
