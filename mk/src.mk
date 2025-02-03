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

# libs
C += $(wildcard lib/src/*.c*) $(wildcard lib/*/src/*.c*)
H += $(wildcard lib/inc/*.h*) $(wildcard lib/*/inc/*.h*)

# ini
S += $(wildcard lib/*.ini) $(wildcard lib/*.f)
