.PHONY: sync
sync: $(HOME)/.unison/$(APP).prf
	unison $(APP)
$(HOME)/.unison/$(APP).prf: $(CWD)/.unison
	ln -fs $< $@
