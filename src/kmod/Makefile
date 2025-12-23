APP = prectimer
KO  = $(APP).ko
  
obj-m += $(APP).o

.PHONY: all run clean

all: $(KO)
$(KO): *.c Makefile
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

run: $(KO)
	-sudo rmmod $<
	sudo insmod $<
	sudo dmesg -w
# sudo dmesg | grep prectimer | grep "delta:" > tmp/kmod.log

clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
