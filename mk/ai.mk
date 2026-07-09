.PHONY: ai
ai: sync
	cat doc/decl/core/*.md doc/vending/*.md \
	doc/decl/js/*.md js/*.*js package.json \
		doc/$(APP)/*.md README.md doc/ai.md > tmp/$(APP).ai.md

# 		doc/decl/js/*.md ts/*.ts package.json tsconfig.json js/*.js \
# 		doc/decl/py/*.md \
# 		doc/decl/hw/*.md doc/decl/esp/*.md \
# 		doc/decl/rust/*.md Cargo.toml src/*.rs \

# 		doc/decl/vending/*.md doc/decl/vending/command/*.md \
#		doc/decl/horizon/*.md \
