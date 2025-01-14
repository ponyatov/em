RF += $(REF)/picolibc/README.md
$(REF)/picolibc/README.md:
	$(GITREF) git@github.com:ponyatov/picolibc.git $(dir $@)

RF += $(REF)/newlib-salsa/README
$(REF)/newlib-salsa/README: /usr/src/newlib/newlib-$(NEWLIB_VER).tar.xz
	cd $(REF) ; xzcat $< | tar x && touch $@
