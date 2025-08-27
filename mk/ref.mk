REF += $(CROSS)/src/newlib-salsa/README
$(CROSS)/src/newlib-salsa/README: /usr/src/newlib/$(NEWLIB_GZ)
	cd $(dir $@)/.. ; xzcat $< | tar x && touch $@

REF += $(CROSS)/src/$(GMP)/README
REF += $(CROSS)/src/$(MPFR)/README
REF += $(CROSS)/src/$(MPC)/README

REF += $(CROSS)/src/$(BINUTILS)/README
REF += $(CROSS)/src/$(GCC)/README
REF += $(CROSS)/src/$(GDB)/README

REF += $(CROSS)/src/$(LINUX)/README
REF += $(CROSS)/src/$(UCLIBC)/README
REF += $(CROSS)/src/$(BB)/README

REF += ref/STM32CubeL4/README.md
ref/STM32CubeL4/README.md:
	$(GITREF) https://github.com/STMicroelectronics/STM32CubeL4.git $(dir $@)

REF += ref/STM32CubeF4/README.md
ref/STM32CubeF4/README.md:
	$(GITREF) https://github.com/STMicroelectronics/STM32CubeF4.git $(dir $@)

REF += ref/STM32CubeF1/README.md
ref/STM32CubeF1/README.md:
	$(GITREF) https://github.com/STMicroelectronics/STM32CubeF1.git $(dir $@)

REF += ref/WARDuino/README.md
ref/WARDuino/README.md:
	$(GITREF) https://github.com/ponyatov/WARDuino.git $(dir $@)
