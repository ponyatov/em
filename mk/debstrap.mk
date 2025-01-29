MM_SUITE  = $(shell lsb_release -sc)
MM_MIRROR = $(CWD)/etc/apt/sources.list
MM       += --variant=minbase
MM       += --include=init,live-boot
MM       += --include=linux-image-amd64,linux-headers-amd64
MM       += --include=firmware-linux-free,firmware-linux-nonfree

root/done: tmp/squid
	sudo rm -rf root
	sudo mmdebstrap $(MM) $(MM_SUITE) root $(MM_MIRROR)
