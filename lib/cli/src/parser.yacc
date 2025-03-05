%{
    #include "parser.hpp"
    #include "vm.hpp"
%}

%defines %union { Object *o; }

%token<o> INT NUM
%type<o>  ex

%%

syntax: | syntax ex { push($2); dump(); }

ex : INT
   | NUM
