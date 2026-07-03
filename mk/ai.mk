.PHONY: ai
ai: sync
	cat README.md \
		doc/decl/core/*.md \
		doc/decl/cpp/*.md inc/*.h* src/*.c* src/*.l* src/*.y* src/*.r* \
			README.md doc/ai.md > tmp/$(APP).ai.md

# 		doc/decl/js/*.md ts/*.ts package.json tsconfig.json js/*.js \
# 		doc/decl/py/*.md \
# 		doc/decl/hw/*.md doc/decl/esp/*.md \
# 		doc/decl/rust/*.md Cargo.toml src/*.rs \

# 		doc/decl/vending/*.md doc/decl/vending/command/*.md \
#		doc/decl/horizon/*.md \
