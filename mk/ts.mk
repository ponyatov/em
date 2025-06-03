RTARGET = wasm32-unknown-unknown

$(NPM):
	sudo aptinstall -uy npm nodejs
$(TSC) $(YO): $(NPM)
	npm i -g typescript yo generator-langium
