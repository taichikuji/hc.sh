SERVICE_NAME=hc.service
SCRIPT_NAME=hc.sh
CONF_NAME=hc.conf
INSTALL_DIR=/usr/local/bin
SYSTEMD_DIR=/etc/systemd/system
CONF_DIR=/etc

.PHONY: install uninstall enable

install:
	@echo "Installing $(SCRIPT_NAME) to $(INSTALL_DIR)..."
	cp $(SCRIPT_NAME) $(INSTALL_DIR)/$(SCRIPT_NAME)
	chmod +x $(INSTALL_DIR)/$(SCRIPT_NAME)
	@echo "Installing $(CONF_NAME) to $(CONF_DIR)..."
	cp $(CONF_NAME) $(CONF_DIR)/$(CONF_NAME)
	@echo "Installing $(SERVICE_NAME) to $(SYSTEMD_DIR)..."
	cp $(SERVICE_NAME) $(SYSTEMD_DIR)/$(SERVICE_NAME)
	sed -i 's|/<location>/hc.sh|$(INSTALL_DIR)/$(SCRIPT_NAME)|g' $(SYSTEMD_DIR)/$(SERVICE_NAME)
	@echo "Installation complete. Please ensure $(CONF_DIR)/$(CONF_NAME) is configured before enabling."

uninstall:
	@echo "Uninstalling $(SERVICE_NAME)..."
	systemctl stop $(SERVICE_NAME) || true
	systemctl disable $(SERVICE_NAME) || true
	rm -f $(INSTALL_DIR)/$(SCRIPT_NAME)
	rm -f $(SYSTEMD_DIR)/$(SERVICE_NAME)
	rm -f $(CONF_DIR)/$(CONF_NAME)
	systemctl daemon-reload
	@echo "Uninstallation complete."

enable:
	@echo "Enabling $(SERVICE_NAME)..."
	systemctl daemon-reload
	systemctl enable $(SERVICE_NAME)
	systemctl start $(SERVICE_NAME)
	@echo "Service enabled and started."
