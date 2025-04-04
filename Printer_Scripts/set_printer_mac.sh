#!/bin/bash
echo "Finding Printer Device..."

MAC_ADDR=$(hcitool scan | grep PT-210 | awk '{print $1}')

if [ -z "$MAC_ADDR" ]; then
	echo "Printer Not Found!"
	exit 1
fi

echo "Found Printer! Address is $PRINTER_MAC_ADDR"
export PRINTER_MAC_ADDR=$MAC_ADDR
echo "Registered Printer Address... Done!"
