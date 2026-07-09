#include "posix.hpp"
#include "compiler.hpp"

std::map<std::string, addr> _label;

void label(std::string s) { _label[s] = Cp; }

addr compile(byte b) {
    assert(Cp < Msz);
    M[Cp++] = b;
    return Cp;
}

addr compile(addr a) {
    compile((byte)((a >> 0) & 0xFF));
    compile((byte)((a >> 1) & 0xFF));
    return Cp;
}

addr compile(cell c) {
    compile((byte)((c >> 0) & 0xFF));
    compile((byte)((c >> 1) & 0xFF));
    compile((byte)((c >> 2) & 0xFF));
    compile((byte)((c >> 3) & 0xFF));
    return Cp;
}

addr compile(Op op) {
    fprintf(stderr, "\n%.4i: %.2X", Cp, op);
    compile((byte)op);
    return Cp;
}

addr compile(Op op, byte b) {
    fprintf(stderr, "\n%.4i: %.2X %.2X", Cp, op, b);
    return Cp;
}

addr compile(Op op, addr a) {
    fprintf(stderr, "\n%.4i: %.2X %.4X", Cp, op, a);
    return Cp;
}

addr compile(Op op, cell c) {
    fprintf(stderr, "\n%.4i: %.2X %.8X", Cp, op, c);
    return Cp;
}
