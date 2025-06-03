.PHONY : install update ref gz
install: $(WS)_install $(RUSTUP) $(PIP) doc ref gz
	$(RUSTUP) component add rustfmt
	$(RUSTUP) target    add $(RTARGET)
	$(RUSTUP) component add rust-src --toolchain nightly
	$(MAKE) update
update : $(WS)_update $(RUSTUP) $(PIP) $(NPM) $(TSC) $(YO)
	$(RUSTUP) self update
	$(RUSTUP)      update
	$(PIP) install -U -r requirements.txt
ref    : $(RF)
gz     : $(GZ)

Debian_install: Debian_update
# sudo dpkg --add-architecture i386
Debian_update:
	sudo apt update
	sudo apt install -uy `cat apt.$(WS)` $(APT)
	$(PIP) install -U    pip
	$(PIP) install -U -r requirements.txt

Msys_install: doc ref gz
	pacman -Suy
Msys_update:
	pacman -S $(shell cat apt.$(WS) | tr '\n' ' ') $(MSYS)

$(PY) $(PIP):
	python3 -m venv .

.PHONY: rust
rust: $(RUSTUP)
	$< self update
$(RUSTUP):
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
