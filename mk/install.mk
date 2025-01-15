# install
.PHONY: install update ref gz
install: update doc ref gz
update:
	sudo dpkg --add-architecture i386
	sudo apt update
	sudo apt install -uy `cat apt.$(shell lsb_release -si)` $(APT)
ref: $(RF)
gz:  $(GZ)
