#!/bin/bash
echo "Finding Printer Device..."

MAC_ADDR=$(hcitool scan | grep PT-210 | awk '{print $1}')

echo "Found Printer! Address is $MAC_ADDR"
export PRINTER_MAC=$MAC_ADDR
