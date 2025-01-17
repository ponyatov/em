
CUBEMX_VER_ = $(subst .,-,$(CUBEMX_VER))
CUBEMX_GZ   = en.stm32cubemx-lin-v$(CUBEMX_VER_).zip

GZ += $(DISTR)/STM32/$(CUBEMX_GZ)
$(DISTR)/STM32/$(CUBEMX_GZ):
	$(CURL) $@ http://klen.org/Files/DevTools/mx/en.stm32cubemx-lin-$(CUBEMX_VER).zip

.PHONY: cubemx
cubemx: $(HOME)/STM32/CubeMX/STM32CubeMX
$(HOME)/STM32/CubeMX/STM32CubeMX: /tmp/cubemx/SetupSTM32CubeMX-$(CUBEMX_VER)
	- $^
	touch $@
/tmp/cubemx/SetupSTM32CubeMX-$(CUBEMX_VER): $(DISTR)/STM32/$(CUBEMX_GZ)
	unzip $< -d $(dir $@) && touch $@

RF += $(REF)/32l496gdiscovery-bsp/README.md
$(REF)/32l496gdiscovery-bsp/README.md:
	$(GITREF) https://github.com/ponyatov/32l496gdiscovery-bsp.git $(dir $@) && touch $@
