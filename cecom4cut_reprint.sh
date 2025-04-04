#!/bin/bash
LAST_FILE_DATE=$(ls result/ | grep ".bmp" | grep -v "qr" | tac | head -n 1 | sed 's/\.bmp//')

IMAGE_FILENAME=$LAST_FILE_DATE
IMAGE_HEIGHT=636
IMAGE_WIDTH=320

if [ -z "$PRINTER_MAC" ]; then
	echo "Printer address is not registered."
	echo "Please run <source set_printer_mac.sh> first"
	exit 1
fi

sleep 1

echo "Printing Image..."
bash Printer_Scripts/print_bmp.sh "result/$IMAGE_FILENAME.bmp" $IMAGE_HEIGHT $IMAGE_WIDTH
sleep 0.1
bash Printer_Scripts/print_feed.sh 50
echo "Print Image Done..!"
