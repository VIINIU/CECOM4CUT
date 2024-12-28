#!/bin/sh

# Read PRINTER_MAC
read -p "Enter PRINTER_MAC address: " PRINTER_MAC

sed "s/PRINTER_MAC_INPUT/$PRINTER_MAC/g" cecom4cut_listener.service.example > cecom4cut_listener.service

# Register as System Daemon
sudo cp cecom4cut_listener.service /etc/systemd/system/cecom4cut_listener.service

sudo systemctl daemon-reload
sudo systemctl enable cecom4cut_listener.service
sudo systemctl start cecom4cut_listener.service

echo "CECOM4CUT Service has been set up and started with Printer[$PRINTER_MAC]"
