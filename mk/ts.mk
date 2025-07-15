# npm install -g yo generator-code
$(NPM):
	sudo apt install -uy npm nodejs
$(TSC): $(NPM)
	npm install -g typescript
$(DENO): $(NPM)
	npm install -g deno
