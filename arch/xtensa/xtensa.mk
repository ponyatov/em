TARGET    = xtensa-lx106-elf
OS       ?= rtos8266
APT      += gcc-xtensa-lx106 qemu-system-misc
QEMU      = qemu-system-xtensa
QEMU_CFG += -machine esp8266 -nographic

TCC      = $(ESP)/$(TARGET)/bin/$(TARGET)-gcc
TXX      = $(ESP)/$(TARGET)/bin/$(TARGET)-g++
TAS      = $(ESP)/$(TARGET)/bin/$(TARGET)-as
TLD      = $(ESP)/$(TARGET)/bin/$(TARGET)-ld
TSIZE    = $(ESP)/$(TARGET)/bin/$(TARGET)-size
TOBJDUMP = $(ESP)/$(TARGET)/bin/$(TARGET)-objdump

LX106_URL = https://dl.espressif.com/dl
LX106_GZ  = $(TARGET)-gcc$(LX106_GCC)-esp-$(LX106_VER)-linux-amd64.tar.gz

GZ += $(TCC)
$(TCC): $(DISTR)/ESP/$(LX106_GZ)
	cd $(ESP) ; zcat $< | tar x && touch $@
$(DISTR)/ESP/$(LX106_GZ):
	$(CURL) $@ $(LX106_URL)/$(LX106_GZ)

RTOS8266_URL = https://github.com/espressif/ESP8266_RTOS_SDK/releases/download
RTOS8266_GZ  = ESP8266_RTOS_SDK-v$(RTOS8266_VER).zip

GZ += $(ESP)/ESP8266_RTOS_SDK/bin/pip3
$(ESP)/ESP8266_RTOS_SDK/bin/pip3: $(DISTR)/ESP/$(RTOS8266_GZ)
	unzip -d $(ESP) $<
	cd $(ESP)/ESP8266_RTOS_SDK ; python3 -m venv . ; $@ -U -r requirements.txt
$(DISTR)/ESP/$(RTOS8266_GZ):
	$(CURL) $@ $(RTOS8266_URL)/v${RTOS8266_VER)/$(RTOS8266_GZ)

ESPTOOL_GZ = esptool-v$(ESPTOOL_VER)-linux-arm64.zip
ESPTOOL_URL = https://github.com/espressif/esptool/releases/download

GZ += $(ESP)/esptool/esptool.py
$(ESP)/esptool/esptool.py: $(DISTR)/ESP/$(ESPTOOL_GZ)
	unzip $< -d $(dir $@) && touch $@
$(DISTR)/ESP/$(ESPTOOL_GZ):
	$(CURL) $@ $(ESPTOOL_URL)/v$(ESPTOOL_VER)/$(ESPTOOL_GZ)
