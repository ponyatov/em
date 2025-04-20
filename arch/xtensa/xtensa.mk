TARGET    = xtensa-lx106-elf
OS       ?= rtos8266

APT      += gcc-xtensa-lx106 qemu-system-misc
# APT += python3-future python3-cryptography
# APT += python3-pyparsing python3-pyelftools python3-pyparsing

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

GZ += $(ESP)/ESP8266_RTOS_SDK/README.md
$(ESP)/ESP8266_RTOS_SDK/README.md: $(DISTR)/ESP/$(RTOS8266_GZ)
	unzip -d $(ESP) $< && touch $@
$(DISTR)/ESP/$(RTOS8266_GZ):
	$(CURL) $@ $(RTOS8266_URL)/v${RTOS8266_VER)/$(RTOS8266_GZ)

ESPTOOL_GZ  = esptool-v$(ESPTOOL_VER)-linux-amd64.zip
ESPTOOL_URL = https://github.com/espressif/esptool/releases/download

GZ += $(ESPTOOL)
$(ESPTOOL): $(DISTR)/ESP/$(ESPTOOL_GZ)
	unzip -d $(ESP) $< && touch $@ ; chmod +x $@
$(DISTR)/ESP/$(ESPTOOL_GZ):
	$(CURL) $@ $(ESPTOOL_URL)/v$(ESPTOOL_VER)/$(ESPTOOL_GZ)

GZ += $(PIP)
$(PIP):
	python3 -m venv $(ESP)/python
	$@ install -U pip
	$@ install -U -r $(IDF_PATH)/requirements.txt

IDF_CFG  = PROJECT_NAME=$(MODULE)
IDF_CFG += EXTRA_COMPONENT_DIRS="$(CWD)/lib $(CWD)/src"
IDF_CFG += PROJECT_PATH=$(CWD) BUILD_DIR_BASE=$(TMP)/build
IDF_CFG += EXCLUDE_COMPONENTS="lwip fatfs freemodbus esp_http_server wpa_supplicant"

.PHONY: menuconfig
menuconfig:
	$(MAKE) -f $(IDF_PATH)/make/project.mk $(IDF_CFG) $@

.PHONY: all
all:
	$(MAKE) -f $(IDF_PATH)/make/project.mk $(IDF_CFG) $@

.PHONY: list-components
list-components:
	$(MAKE) -f $(IDF_PATH)/make/project.mk $(IDF_CFG) $@
