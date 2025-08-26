#include "vm.hpp"
#include "os.hpp"

byte M[Msz];
addr Cp = sizeof(bcHeader);
addr Ip = 0xFFFF;  // uninitialized fake value breaks if not configured
addr R[Rsz];
byte Rp = 0;
cell D[Dsz];
byte Dp = 0;

bool trace = true;

void nop() {
    if (trace) fprintf(stderr, "nop\n");
}

void halt() {
    if (trace) fprintf(stderr, "halt\n\n");
    exit(0);
}

void dump() {
    if (trace) fprintf(stderr, "dump\n");
    fprintf(stderr, "\n[ ");
    for (uint i = 0; i < Dp; i++) fprintf(stderr, "%i ", D[i]);
    fprintf(stderr, "\t]\n");
}

void dot() {
    if (trace) fprintf(stderr, "dot\n");
    Dp = 0;
}

void dup() {
    if (trace) fprintf(stderr, "dup\n");
    assert(Dp >= 1);
    push(top());
}

void drop() {
    if (trace) fprintf(stderr, "drop\n");
    assert(Dp >= 1);
    pop();
}

void swap() {
    if (trace) fprintf(stderr, "swap\n");
    assert(Dp >= 2);
    cell b = pop();
    cell a = pop();
    push(b);
    push(a);
}

void over() {
    if (trace) fprintf(stderr, "over\n");
    assert(Dp >= 2);
    cell b = pop();
    cell a = pop();
    push(a);
    push(b);
    push(a);
}

void rot() {
    if (trace) fprintf(stderr, "rot\n");
    assert(Dp >= 3);
    cell c = pop();
    cell b = pop();
    cell a = pop();
    push(b);
    push(c);
    push(a);
}

void mrot() {
    if (trace) fprintf(stderr, "mrot\n");
    assert(Dp >= 3);
    cell c = pop();
    cell b = pop();
    cell a = pop();
    push(c);
    push(a);
    push(b);
}

void pick() {
    if (trace) fprintf(stderr, "pick\n");
    assert(Dp >= 2);
    uint8_t i = pop();
    assert(i >= 0 && i < Dp);
    push(D[Dp - 1 - i]);
}

void depth() {
    if (trace) fprintf(stderr, "depth\n");
    push(Dp);
}

void push(cell n) {
    assert(Dp < Dsz);
    D[Dp++] = n;
}

cell pop() {
    assert(Dp > 0);
    return D[--Dp];
}

cell top() {
    assert(Dp > 0);
    return D[Dp - 1];
}

void init() {
    if (trace) fprintf(stderr, "init\n");
    bcHeader* header = (bcHeader*)M;
    char bcx[4] = "bcx";
    strcpy(header->magic, bcx);
    sync_();
}

void sync_() {
    if (trace) fprintf(stderr, "sync\n");
    bcHeader* header = (bcHeader*)M;
    header->max = Msz;
    header->Cp = Cp;
    header->Ip = Ip;
    header->Rmax = Rsz;
    header->Dmax = Dsz;
    header->latest = 0;  // no vocabulary
}

void save() {
    sync_();
    if (trace) fprintf(stderr, "save\n");
    FILE* bc;
    assert(bc = fopen(("tmp/" APP ".bcx"), "wb"));
    fwrite(M, 1, Cp, bc);
    fclose(bc);
}
