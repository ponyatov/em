ISOLINUX += root/isolinux/isohdpfx.bin
ISOLINUX += root/isolinux/isohdppx.bin
ISOLINUX += root/isolinux/isolinux.bin
.PHONY: isolinux
isolinux: $(ISOLINUX)

root/isolinux/%: /usr/lib/ISOLINUX/%
	cp $< $@
