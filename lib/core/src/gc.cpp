#include "object.hpp"
#include <assert.h>

Object::Object() {
    ref = 0;
    next = pool;  // \ register object in global pool
    pool = this;  // /
}

Object *Object::pool = nullptr;

Object::~Object() { assert(!ref); }
