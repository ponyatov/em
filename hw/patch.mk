#!/usr/bin/make -f

PATCH = $(wildcard *.patch)
FILES = $(subst .patch,,$(PATCH))
FIXES = $(subst .patch,.fix,$(PATCH))

.PHONY: all
all:
	dos2unix $(FILES)
	$(MAKE) -f $(MAKEFILE_LIST) $(FIXES)
%.fix: %
	dos2unix $<
	patch -u $< $<.patch
	touch $@
