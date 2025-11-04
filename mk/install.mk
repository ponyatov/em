.PHONY : install update ref gz
#  $(PIP) $(RUSTUP) $(TSC) $(OPAM)
install: $(WS)_install doc ref gz
	$(MAKE) update
update : $(WS)_update
	$(RUSTUP) self update && $(RUSTUP) update
	$(PIP) install -U    pip
	$(PIP) install -U -r requirements.txt
	opam install -y . --deps-only && dune build
	$(NPM) update
ref    : $(RF)
gz     : $(GZ)

Debian_install:
# sudo dpkg --add-architecture i386
Debian_update: apt.Debian
	sudo apt update
	sudo apt install -uy `cat $<` $(APT)
	$(PIP) install -U    pip
	$(PIP) install -U -r requirements.txt

Ubuntu_install:
Ubuntu_update: apt.Ubuntu
	sudo apt update
	sudo apt install -uy `cat $<` $(APT)

Msys_install:
	pacman -Suy
Msys_update: apt.Msys
	pacman -S $(shell cat $< | tr '\n' ' ') $(MSYS)
