# hardware_manager

Contains systemd services and udev rules for managing hardware and background services.

## Installation and Updating

### 1. Systemd Services

To install or update the systemd services (`gst-webrtc-signalling-server.service`, `rosbridge.service`, and `microxrce.service`), copy them to the system systemd directory.

1. **Copy the units:**
   ```bash
   cd ~/workspace/hardware_manager
   sudo cp *.service /etc/systemd/system/
   ```
2. **Reload the systemd daemon:**
   ```bash
   sudo systemctl daemon-reload
   ```
3. **Enable the services to start at boot (optional):**
   ```bash
   sudo systemctl enable gst-webrtc-signalling-server.service rosbridge.service microxrce.service
   ```
4. **Start or restart the services:**
   ```bash
   sudo systemctl restart gst-webrtc-signalling-server.service rosbridge.service microxrce.service
   ```

### 2. Udev Rules

The udev rule ensures that `microxrce.service` automatically starts when the proper USB tracker device is plugged in.

1. **Copy the rules file:**
   ```bash
   cd ~/workspace/hardware_manager
   sudo cp 99-uas-usb.rules /etc/udev/rules.d/
   ```
2. **Reload the udev rules and trigger them:**
   ```bash
   sudo udevadm control --reload-rules
   sudo udevadm trigger
   ```
