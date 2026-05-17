RF += doc/WebAssembly-3.0-draft.pdf
doc/WebAssembly-3.0-draft.pdf:
	$(CURL) $@ https://webassembly.github.io/spec/versions/core/WebAssembly-3.0-draft.pdf

RF += doc/WebAssembly_3.0.pdf
doc/WebAssembly_3.0.pdf:
	$(CURL) $@ https://webassembly.github.io/spec/core/_download/WebAssembly.pdf

RF += ref/kaitai-webassembly/README.md
ref/kaitai-webassembly/README.md:
	$(GITREF) https://github.com/evacchi/kaitai-webassembly.git $(dir $@)

RF += ref/kaitai_struct_cpp_stl_runtime/README.md
ref/kaitai_struct_cpp_stl_runtime/README.md:
	$(GITREF) https://github.com/kaitai-io/kaitai_struct_cpp_stl_runtime $(dir $@)
