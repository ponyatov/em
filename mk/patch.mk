#!/usr/bin/make -f

FIXES = $(wildcard *.fix           )
FILES = $(patsubst %.fix,%,$(FIXES))
# PATCH = $(wildcard *.patch               )
# FIXES = $(patsubst %.patch,%.fix,$(PATCH))

.PHONY: all
all:
	dos2unix $(FILES)
	$(MAKE) -f $(MAKEFILE_LIST) $(FIXES)
%.fix: %
#	cp $@ $<
 	meld $< $@
# 	patch -u $< $<.patch && touch $@
# rm Core/Src/syscalls.c
