#include "cli.hpp"
#include "os.hpp"

#ifdef LEMON
void cli(char* filename) {
    yyfile = filename;
    yylineno = 0;
    // open
    assert((yyin = open(yyfile, O_RDONLY)));
    // get host memory spec
    int pagesize = 0;
    assert((pagesize = getpagesize()) == 4096);
    // get file size
    struct stat st;
    assert(0 == fstat(yyin, &st));
    assert(st.st_size);
    char* buf = (char*)mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, yyin, 0);
    assert(buf);
    // parse
    cli(buf, buf + st.st_size);
    // close file
    munmap(buf, pagesize);
    close(yyin);
    yyfile = nullptr;
    yylineno = 0;
}
#else   // flex/bison
void cli(char* filename) {
    yyfile = filename;
    yylineno = 1;
    assert(yyin = fopen(yyfile, "r"));
    yyparse();
    fclose(yyin);
    yyfile = nullptr;
    yylineno = 0;
}
#endif  // LEMON

extern int main(int argc, char* argv[]) {
    arg(0, argv[0]);
    init();
    for (int i = 1; i < argc; i++) {
        arg(i, argv[i]);
        cli(argv[i]);
    }
    save();
    return 0;
}

extern void arg(int argc, char* argv) {  //
    fprintf(stderr, "arg[%i] = <%s>\n", argc, argv);
}
