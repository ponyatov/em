.PHONY: ai tmp/$(APP).ai.md
ai: tmp/$(APP).ai.md
tmp/$(APP).ai.md:
	rsync -r $(HOME)/metadoc/$(APP)/ doc/
	cat README.md doc/*.md $(C) $(H) $(LX) > $@ ; touch $@
