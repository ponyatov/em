%{
    #include "cli.hpp"

    static std::string bin(int b) {
        char buf[0x20];
        snprintf(buf,sizeof(buf),"%b",b);
        return buf;
    }
%}

%defines %union { char c; int n; float f; std::string* s; uint8_t b; }

%define api.token.prefix {t_}

%token    COLON
%token<s> ID
%token<b> CMD0 CMDb CMDa CMDc
%token<n> INT

%token<c> CHAR
%token<n> INT HEX OCT BIN
%token<f> NUM
%token<s> STR

%%
syntax : | syntax ex

ex: COLON ID    { label(*$2);               }
  | CMD0        { compile((Op)$1         ); }
  | CMDb INT    { compile((Op)$1,(byte)$2); }
  | CMDa INT    { compile((Op)$1,(addr)$2); }
  | CMDc INT    { compile((Op)$1,(cell)$2); }
