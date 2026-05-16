#!/bin/bash

# Ensure script is run with sudo
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (use sudo ./install.sh)"
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
cd "$SCRIPT_DIR"

echo "Installing/updating systemd services..."
if [ -d "units" ] && ls units/*.service >/dev/null 2>&1; then
    cp units/*.service /etc/systemd/system/
    
    echo "Reloading systemd daemon..."
    systemctl daemon-reload

    for service_file in units/*.service; do
        service_name="$(basename "$service_file")"
        echo "Enabling $service_name to auto-start at boot..."
        systemctl enable "$service_name"
        
        echo "Restarting $service_name..."
        systemctl restart "$service_name" || echo "Failed to restart $service_name (ignoring)"
    done
else
    echo "No systemd units found in ./units directory."
fi

echo "Installing/updating udev rules..."
if [ -d "udev" ] && ls udev/*.rules >/dev/null 2>&1; then
    cp udev/*.rules /etc/udev/rules.d/
    echo "Reloading udev rules..."
    udevadm control --reload-rules
    udevadm trigger
else
    echo "No udev rules found in ./udev directory."
fi

echo "Done!"
