REF += $(HOME)/src/newlib-salsa/README
$(HOME)/src/newlib-salsa/README: /usr/src/newlib/$(NEWLIB_GZ)
	mkdir -p $(HOME)/src ; cd $(HOME)/src ;\
	xzcat $< | tar x && touch $@

REF += $(HOME)/src/$(GCC)/README
$(HOME)/src/$(GCC)/README: /usr/src/gcc-12/$(GCC_GZ)
	mkdir -p $(HOME)/src ; cd $(HOME)/src ;\
	xzcat $< | tar x && touch $@

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
