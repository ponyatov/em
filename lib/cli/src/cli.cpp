#include "os.hpp"
#include "cli.hpp"

char* yyfile = nullptr;
int yyin = 0;

#ifdef POSIX

void cli(char* filename) {
    yyfile = filename;
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
    cli(buf, buf + st.st_size);
    munmap(buf, pagesize);
    // mmap(fileno(yyin), filesize, PROT_READ, MAP_SHARED, fileno(yyin), 0);//+
    close(yyin);
    yyfile = nullptr;
}

#endif  // POSIX
