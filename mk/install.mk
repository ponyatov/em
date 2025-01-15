# install
.PHONY: install update ref gz
install: update doc ref gz
	sudo dpkg --add-architecture i386
update:
	sudo apt update
	sudo apt install -uy `cat apt.$(shell lsb_release -si)` $(APT)
ref: $(RF)
gz:  $(GZ)
