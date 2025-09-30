bin/$(BINFILE): $(C) $(H) $(CP) $(HP) $(MK) $(CM)
	cmake --fresh --preset linux
	cmake --build --preset linux -j

$(ELF): $(C) $(H) $(CP) $(HP) $(MK) $(CM)
	cmake --fresh --preset ${HW}
	cmake --build --preset ${HW} -j

$(CROSS)/src/%/README: $(DISTR)/%.tar.xz
	cd $(dir $@)/.. ; xzcat $< | tar x && touch $@
$(CROSS)/src/%/README: $(DISTR)/%.tar.gz
	cd $(dir $@)/.. ;  zcat $< | tar x && touch $@

static/%.wasm: src/%.wat
	wat2wasm $< -o $@ && wasm-objdump -x $@


RU = pavel
tmp/slide/%.ru.mp3: tmp/slide/%.ru.md mk/rule.mk
	RHVoice-test -i $< -o $@ -p $(RU)

VIDEO = -c:v libx264 -vf "scale=1280:720,fps=1" -r 1 -preset ultrafast -crf 28
AUDIO = -c:a aac -b:a 128k -ac 1 -ar 44100
.PHONY: video
video: tmp/slide/slide.mp4
# tmp/slide/slide.mp4: tmp/slide/files.audio $(MP3) $(PNG) mk/rule.mk
# 	ffmpeg -loop 1 -i $(PNG) -f concat -i $< $(VIDEO) $(AUDIO) -shortest $@
