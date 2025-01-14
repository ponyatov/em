RF += $(REF)/picolibc/README.md
$(REF)/picolibc/README.md:
	$(GITREF) git@github.com:ponyatov/picolibc.git $(dir $@)

RF += $(REF)/newlib-salsa/README.md
$(REF)/newlib-salsa/README.md: /usr/src/newlib/newlib-$(NEWLIB_VER).tar.xz
	cd $(REF)/newlib-salsa ; xzcat $< | tar x
