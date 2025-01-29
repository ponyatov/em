#include "object.hpp"

Object *Object::pool = nullptr;

Object::Object() {
    ref = 0;
    next = pool;
    pool = this;
}

Object::~Object() {}

void Object::dump() { fprintf(stderr, "object:\n"); }
