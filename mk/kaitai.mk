GZ         += $(KAITAI)
KAITAI_DEB  = kaitai-struct-compiler_$(KAITAI_VER)_all.deb
KAITAIL_URL = https://github.com/kaitai-io/kaitai_struct_compiler/releases/download
$(KAITAI): $(DISTR)/Linux/$(KAITAI_DEB)
	sudo dpkg -i $^ && sudo touch $@
$(DISTR)/Linux/$(KAITAI_DEB):
	$(CURL) $@ $(KAITAIL_URL)/$(KAITAI_VER)/$(KAITAI_DEB)
