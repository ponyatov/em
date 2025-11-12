.PHONY: ai tmp/$(APP).ai.md
ai: tmp/$(APP).ai.md
tmp/$(APP).ai.md: doc
	cat doc/ai.md README.md doc/$(APP)/*.md $(C) $(H) $(LX) > $@ ; touch $@
