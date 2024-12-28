#!/bin/bash
LAST_FILE_DATE=$(ls result/ | grep ".bmp" | grep -v "qr" | tac | head -n 1 | sed 's/\.bmp//')

IMAGE_FILENAME=$LAST_FILE_DATE
IMAGE_HEIGHT=240
IMAGE_WIDTH=320
QR_HEIGHT=100
QR_WIDTH=320

if [ -z "$PRINTER_MAC" ]; then
	echo "Printer address is not registered."
	echo "Please run <source set_printer_mac.sh> first"
	exit 1
fi

sleep 1

echo "Printing Image..."
bash Printer_Scripts/print_bmp.sh "resources/frame_h_rev.bmp" 40 $IMAGE_WIDTH
sleep 0.1
bash Printer_Scripts/print_bmp.sh "result/$IMAGE_FILENAME.bmp" $((IMAGE_HEIGHT + 5)) $IMAGE_WIDTH
sleep 0.1
bash Printer_Scripts/print_bmp.sh "resources/frame_f_rev.bmp" 255 $IMAGE_WIDTH
sleep 0.1
bash Printer_Scripts/print_bmp.sh "result/$IMAGE_FILENAME.qr.bmp" $((QR_HEIGHT + 5)) $QR_WIDTH
sleep 0.1
bash Printer_Scripts/print_feed.sh 5
echo "Print Image Done..!"
