.PHONY: sync
sync: doc
	unison decl
	unison $(APP)
