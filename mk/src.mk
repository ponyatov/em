MK += Makefile
MK += $(wildcard   mk/*.mk)
MK += $(wildcard   hw/$(HW).mk)
MK += $(wildcard  cpu/$(CPU).mk)
MK += $(wildcard arch/*.mk)
MK += $(wildcard   os/$(OS).mk)

# project
C += $(wildcard src/*.c*)
H += $(wildcard inc/*.h*)

# cross
C += $(wildcard   hw/src/*.c*) $(wildcard   hw/$(HW)/src/*.c*)
H += $(wildcard   hw/inc/*.h*) $(wildcard   hw/$(HW)/inc/*.h*)
C += $(wildcard  cpu/src/*.c*) $(wildcard  cpu/$(CPU)/src/*.c*)
H += $(wildcard  cpu/inc/*.h*) $(wildcard  cpu/$(CPU)/inc/*.h*)
C += $(wildcard arch/src/*.c*) $(wildcard arch/$(ARCH)/src/*.c*)
H += $(wildcard arch/inc/*.h*) $(wildcard arch/$(ARCH)/inc/*.h*)
C += $(wildcard   os/src/*.c*) $(wildcard   os/$(OS)/src/*.c*)
H += $(wildcard   os/inc/*.h*) $(wildcard   os/$(OS)/inc/*.h*)

# parser
P  += $(wildcard src/*.lex)  $(wildcard src/*.yacc)
CP += $(TMP)/cli.parser.cpp $(TMP)/cli.lexer.cpp
HP += $(TMP)/cli.parser.hpp

# libc
C += $(wildcard lib/c/src/*.c*)
H += $(wildcard lib/c/inc/*.h*)
C += $(wildcard lib/gloss/src/*.c*)
H += $(wildcard lib/gloss/inc/*.h*)
# libs
C += $(wildcard lib/core/src/*.c*)
H += $(wildcard lib/core/inc/*.h*)
C += $(wildcard lib/cli/src/*.c*)
H += $(wildcard lib/cli/inc/*.h*)
C += $(wildcard lib/led/src/*.c*)
H += $(wildcard lib/led/inc/*.h*)

# parser
P += $(wildcard src/*.lex)  $(wildcard src/*.yacc)

# ini
S += $(wildcard lib/*.ini) $(wildcard lib/*.f)
