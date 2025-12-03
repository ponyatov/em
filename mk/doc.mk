.PHONY: doc
doc:
	rsync -r $(HOME)/metadoc/$(APP)/ doc/$(APP)/

.PHONY: doxy
doxy: .doxygen doc/DoxygenLayout.xml doc/logo.png doc
	rm -rf doc/html ; doxygen $< 1>/dev/null
	cargo doc && cp -r target/$(RTARGET)/doc/$(APP) doc/html/

RF += doc/WebAssembly-3.0-draft.pdf
doc/WebAssembly-3.0-draft.pdf:
	$(CURL) $@ https://webassembly.github.io/spec/versions/core/WebAssembly-3.0-draft.pdf
