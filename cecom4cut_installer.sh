#!/bin/bash
sudo apt update && sudo apt install -y python3 bluez
if [ $? -ne 0 ]; then
    echo "Error: Failed to install dependency packages."
    exit 1
fi

bash /set_printer_mac.sh
if [ $? -ne 0 ]; then
    echo "Error: Failed to find and register Printer."
    exit 1
fi

sh /Systemd_scripts/systemd_installer.sh
