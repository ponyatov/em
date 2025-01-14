RF += $(REF)/picolibc/README.md
$(REF)/picolibc/README.md:
	$(GITREF) git@github.com:ponyatov/picolibc.git $(dir $@)
