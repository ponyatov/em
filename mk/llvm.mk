ATRIPLE = arm-none-eabi
ACC = $(ATRIPLE)-gcc -mthumb -mcpu=cortex-m4

tmp/%.o: src/%.ll mk/llvm.mk
	llc -mtriple=$(ATRIPLE) --filetype=obj -o $@ $<

tmp/%.o: hw/l496disco/%.s
	$(ACC) -o $@ -c $<
tmp/%.o: hw/l496disco/Core/Src/%.c
	$(ACC) -o $@ -c $<

OBJ += tmp/none.o
OBJ += tmp/startup_stm32l496xx.o
OBJ += tmp/sysmem.o

tmp/%.elf: $(OBJ) mk/llvm.mk
	$(ACC) -o $@ $<

tmp/%.objdump: tmp/%.elf mk/llvm.mk
	$(ATRIPLE)-objdump -dx $< > $@

.PHONY: ll
ll: tmp/none.objdump
