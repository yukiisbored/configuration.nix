DESTDIR=/

install:
	install -d $(DESTDIR)$(PREFIX)/etc/nixos/
	install -m 644 configuration.nix $(DESTDIR)$(PREFIX)/etc/nixos/
	install -m 644 hardware-configuration.nix $(DESTDIR)$(PREFIX)/etc/nixos/

.PHONY: install
