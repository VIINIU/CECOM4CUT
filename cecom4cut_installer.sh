#!/bin/bash
sudo apt update && sudo apt install -y python3 bluez

bash /set_printer_mac.sh

sh /Systemd_scripts/systemd_installer.sh
