RF += ref/STM32CubeL4/README.md
ref/STM32CubeL4/README.md:
	$(GITREF) https://github.com/STMicroelectronics/STM32CubeL4.git $(dir $@)

RF += ref/STM32CubeF4/README.md
ref/STM32CubeF4/README.md:
	$(GITREF) https://github.com/STMicroelectronics/STM32CubeF4.git $(dir $@)

RF += ref/STM32CubeF1/README.md
ref/STM32CubeF1/README.md:
	$(GITREF) https://github.com/STMicroelectronics/STM32CubeF1.git $(dir $@)
