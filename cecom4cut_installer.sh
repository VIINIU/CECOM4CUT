#!/bin/bash
echo "Installing CECOM4CUT Service..."
echo ""
echo ""

echo "Intalling Project Dependencies..."
echo ""

sudo apt update && sudo apt install -y python3 bluez
if [ $? -ne 0 ]; then
    echo "Error: Failed to install dependency packages."
    exit 1
fi

echo ""
echo "Installed PRoject Dependencies"
echo ""

echo ""
echo "Finding Printer and Registering MAC Address..."
echo ""

bash Printer_Scripts/set_printer_mac.sh
if [ $? -ne 0 ]; then
    echo "Error: Failed to find and register Printer."
    exit 1
fi

echo ""
echo "Found Printer and Registered MAC Address"
echo ""


echo ""
echo "Installing CECOM4CUT Service Daemon..."
echo ""

sh Systemd_scripts/systemd_installer.sh
if [ $? -ne 0 ]; then
    echo "Error: Failed to register CECOM4CUT service to system."
    exit 1
fi

echo ""
echo "Installed CECOM4CUT Service Daemon..."
echo ""

echo "Done..! CECOM4CUT Service has been installed Successfully."
