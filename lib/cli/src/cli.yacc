%{
    #include "app.hpp"

    static std::string bin(int b) {
        char buf[0x20];
        snprintf(buf,sizeof(buf),"%b",b);
        return buf;
    }
%}

%defines %union { char c; int n; float f; std::string *s; }

%define api.token.prefix {t_}

%token<c> CHAR
%token<n> INT HEX OCT BIN
%token<f> NUM
%token<s> STR ID

%token     COLON
%token<s>  INI
%token<op> CMD0 CMD1

%%
ini:| ini ex

ex  : CHAR  { std::clog << "\tchar:" <<              $1  << " "; }
    | INT   { std::clog << "\t int:" <<              $1  << " "; }
    | HEX   { std::clog << "\t hex:" <<  std::hex << $1  << " "; }
    | OCT   { std::clog << "\t oct:" <<  std::oct << $1  << " "; }
    | BIN   { std::clog << "\t bin:" <<          bin($1) << " "; }
    | NUM   { std::clog << "\t num:" <<              $1  << " "; }
    | STR   { std::clog << "\t str:" <<             *$1  << " "; }
    | ID    { std::clog << "\t  id:" <<             *$1  << " "; }
  | COLON ID    { fprintf(stderr,"%.4X: [%s]\n"  , Cp, $2->c_str()); label[*$2] = Cp; }
  | CMD0        { fprintf(stderr,"%.4X: %.2X\n"  , Cp, $1); compile($1); }
