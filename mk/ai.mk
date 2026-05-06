.PHONY: ai
ai: sync
	cat README.md doc/$(APP)/*.md > tmp/$(APP).ai.md
