.PHONY : install update ref gz
# $(PIP) $(RUSTUP) $(TSC)
install: $(WS)_install doc ref gz $(OPAM)
	$(MAKE) update
	sudo adduser $(USER) wireshark
	$(MAKE) systemd
update : $(WS)_update
	$(RUSTUP) self update && $(RUSTUP) update
	$(PIP) install -U    pip
	$(PIP) install -U -r requirements.txt
	opam install -y . --deps-only && dune build
	$(NPM) update
ref    : $(RF)
gz     : $(GZ)

Debian_install Ubuntu_install:
# sudo dpkg --add-architecture i386
Debian_update  Ubuntu_update : apt.$(WS)
	sudo apt update
	sudo apt install -uy `cat $<` $(APT)
	$(PIP) install -U    pip
	$(PIP) install -U -r requirements.txt

Ubuntu_install:
Ubuntu_update: apt.$(WS)
	sudo apt update
	sudo apt install -uy `cat $<` $(APT)

Msys_install:
	pacman -Suy
Msys_update: apt.Msys
	pacman -S $(shell cat $< | tr '\n' ' ')

.PHONY: systemd
systemd: /etc/systemd/system/$(APP)@$(USER).service
	sudo systemctl daemon-reload
	sudo systemctl enable $(APP)@$(USER)
	sudo systemctl restart $(APP)@$(USER)
	sudo systemctl status $(APP)@$(USER)

/etc/systemd/system/$(APP)@$(USER).service: $(CWD)/etc/$(APP).service
	sudo ln -fs $< $@
	ls -la $@
