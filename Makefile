install:
	@echo "Copying scripts into: /usr/local/bin/ ..."
	@cp src/usb-mnt.sh /usr/local/bin/:usb
	echo "Setting permissions..."
	@chmod 755 /usr/local/bin/:usb
	@echo "Installation completed!"
uninstall:
	@echo "Removing scripts..."
	@rm /usr/local/bin/:usb
	@echo "Uninstallation completed!"

