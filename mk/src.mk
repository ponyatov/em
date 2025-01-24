C += $(wildcard src/*.c*)
H += $(wildcard inc/*.h*)

C += $(wildcard   hw/$(HW)/src/*.c*)
H += $(wildcard   hw/$(HW)/inc/*.h*)
C += $(wildcard  cpu/$(CPU)/src/*.c*)
H += $(wildcard  cpu/$(CPU)/inc/*.h*)
C += $(wildcard arch/$(ARCH)/src/*.c*)
H += $(wildcard arch/$(ARCH)/inc/*.h*)
C += $(wildcard   os/$(OS)/src/*.c*)
H += $(wildcard   os/$(OS)/inc/*.h*)

CP += $(TMP)/$(MODULE).parser.cpp $(TMP)/$(MODULE).lexer.cpp
HP += $(TMP)/$(MODULE).parser.hpp

C += $(wildcard lib/c/src/*.c*)
H += $(wildcard lib/c/inc/*.h*)
C += $(wildcard lib/gloss/src/*.c*)
H += $(wildcard lib/gloss/inc/*.h*)
C += $(wildcard lib/cli/src/*.c*)
H += $(wildcard lib/cli/inc/*.h*)
C += $(wildcard lib/led/src/*.c*)
H += $(wildcard lib/led/inc/*.h*)

S += $(wildcard lib/*.ini)
