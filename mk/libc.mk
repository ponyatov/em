RF += $(REF)/picolibc/README.md
$(REF)/picolibc/README.md:
	$(GITREF) git@github.com:ponyatov/picolibc.git $(dir $@)

$(REF)/newlib-salsa/README.md: /usr/src/newlib-3.3.0.tar.xz
