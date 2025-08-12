GZ += /etc/apt/sources.list.d/qucs.ra3xdh.list /etc/apt/trusted.gpg.d/qucs.ra3xdh.gpg
/etc/apt/sources.list.d/qucs.ra3xdh.list:
	echo 'deb http://download.opensuse.org/repositories/home:/ra3xdh/Debian_12/ /' | sudo tee $@
/etc/apt/trusted.gpg.d/qucs.ra3xdh.gpg:
	curl -fsSL https://download.opensuse.org/repositories/home:ra3xdh/Debian_12/Release.key | gpg --dearmor | sudo tee $@ > /dev/null
