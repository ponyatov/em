#include "app.hpp"
#include "os.hpp"
#include "sram.hpp"

void setup() {  //
    BSP_SRAM_Init();
}

void arg(int argc, char *argv) {  //
    fprintf(stderr, "arg[%i] = <%s>\n", argc, argv);
}

void loop() {  //
    exit(0);
}
