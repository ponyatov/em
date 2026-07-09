DOC += doc/WebAssembly-3.0-draft.pdf
doc/WebAssembly-3.0-draft.pdf:
	$(CURL) $@ https://webassembly.github.io/spec/versions/core/WebAssembly-3.0-draft.pdf

.PHONY: doc
doc: $(DOC)
	unison $(APP)

.PHONY: doxy
doxy: .doxygen doc/DoxygenLayout.xml doc/logo.png
	rm -rf doc/html ; doxygen $< 1>/dev/null
	cargo doc && cp -r target/$(RTARGET)/doc/$(APP) doc/html/
