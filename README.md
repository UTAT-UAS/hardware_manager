# hardware_manager

Contains systemd services and udev rules for autostarting offboard computer background services.

## Installation and Updating

**NOTE:** These configurations assume your system is set up with the required dependencies.

```bash
sudo ./install.sh
```

Any `.service` files placed in the `units/` directory and `.rules` files in the `udev/` directory will be automatically discovered, installed, and started (or reloaded).

## Manual Installation

### Systemd Services

To manually install or update a generic systemd service:

1. **Copy the unit:**
   ```bash
   sudo cp units/<your_service>.service /etc/systemd/system/
   ```
2. **Reload the systemd daemon:**
   ```bash
   sudo systemctl daemon-reload
   ```
3. **Enable the service to start at boot:**
   ```bash
   sudo systemctl enable <your_service>.service
   ```
4. **Start or restart the service:**
   ```bash
   sudo systemctl restart <your_service>.service
   ```

### Udev Rules

To manually install or update a set of udev rules:

1. **Copy the rules file:**
   ```bash
   sudo cp udev/<your_rules>.rules /etc/udev/rules.d/
   ```
2. **Reload the udev rules and trigger them:**
   ```bash
   sudo udevadm control --reload-rules
   sudo udevadm trigger
   ```
