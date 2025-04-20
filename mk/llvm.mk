TRIPLE = arm-none-eabi
CC = $(TRIPLE)-gcc -mthumb -mcpu=cortex-m4

tmp/%.o: src/%.ll mk/llvm.mk
	llc -mtriple=$(TRIPLE) --filetype=obj -o $@ $<

tmp/%.o: hw/l496disco/%.s
	$(CC) -o $@ -c $<
tmp/%.o: hw/l496disco/Core/Src/%.c
	$(CC) -o $@ -c $<

OBJ += tmp/none.o
OBJ += tmp/startup_stm32l496xx.o
OBJ += tmp/sysmem.o

tmp/%.elf: $(OBJ) mk/llvm.mk
	$(CC) -o $@ $<

tmp/%.objdump: tmp/%.elf mk/llvm.mk
	$(TRIPLE)-objdump -dx $< > $@

.PHONY: ll
ll: tmp/none.objdump
