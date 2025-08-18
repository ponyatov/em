ISOLINUX += $(ROOT)/isolinux/isohdpfx.bin
ISOLINUX += $(ROOT)/isolinux/isohdppx.bin
ISOLINUX += $(ROOT)/isolinux/isolinux.bin
ISOLINUX += $(ROOT)/isolinux/isolinux.cfg
.PHONY: isolinux
isolinux: $(ISOLINUX)

$(ROOT)/isolinux/isolinux.cfg:
	touch $@
$(ROOT)/isolinux/%: /usr/lib/ISOLINUX/%
	cp $< $@
