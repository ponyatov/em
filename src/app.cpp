#include "vm.hpp"
#include "os.hpp"
#include "sram.hpp"

void setup(){
    printf("\t%s>\n",VM::name);
    BSP_SRAM_Init();
}
