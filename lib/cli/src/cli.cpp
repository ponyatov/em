#include "cli.hpp"
#include "os.hpp"

char* yyfile = nullptr;
int yyin = 0;
int yylineno = 0;

void yyerror(const char* msg) {
#ifdef POSIX
    fprintf(stderr, "\n\n%s:%i %s\n\n", yyfile, yylineno, msg);
    exit(-1);
#else
    for (;;)
        ;  // halt
#endif  // POSIX
}

#ifdef LINUX

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

#endif  // LINUX
