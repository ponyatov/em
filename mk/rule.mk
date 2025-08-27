$(CROSS)/src/%/README: $(DISTR)/%.tar.xz
	cd $(dir $@)/.. ; xzcat $< | tar x && touch $@
$(CROSS)/src/%/README: $(DISTR)/%.tar.gz
	cd $(dir $@)/.. ;  zcat $< | tar x && touch $@

bin/$(BINFILE): $(C) $(H) $(CP) $(HP) $(MK) $(CM)
	cmake --fresh --preset linux
	cmake --build --preset linux -j

$(ELF): $(C) $(H) $(CP) $(HP) $(MK) $(CM)
	cmake --fresh --preset ${HW}
	cmake --build --preset ${HW} -j

static/%.wasm: src/%.wat
	wat2wasm $< -o $@ && wasm-objdump -x $@
