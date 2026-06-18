.PHONY: ai
ai: sync
	cat doc/decl/core/*.md doc/decl/py/*.md \
	doc/vending/*.md doc/$(APP)/*.md README.md \
		doc/ai.md > tmp/$(APP).ai.md
