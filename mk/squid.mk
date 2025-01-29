SQUID      = /usr/sbin/squid
SQUID_CONF = $(CWD)/etc/squid/squid.conf
SQUID_USER = user
SQUID_PASS = pass
SQUID_PORT = 13128

.PHONY: squid
squid: tmp/squid
# $(SQUID) --help
# -f $(SQUID_CONF) -a $(SQUID_PORT) -N -d 7
tmp/squid: /etc/apt/apt.conf.d/S99proxy
	rm -rf $@ ; mkdir -p $@
	$(SQUID) -f $(SQUID_CONF) -z

/etc/apt/apt.conf.d/S99proxy:
	echo 'Acquire::http::Proxy "http://$(SQUID_USER):$(SQUID_PORT)@localhost:$(SQUID_PORT)";' | sudo tee $@
