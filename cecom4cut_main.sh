#!/bin/bash
CURRENT_DATE=$(date +"%Y%m%d_%H%M%S")

IMAGE_FILENAME=$CURRENT_DATE
IMAGE_HEIGHT=240
IMAGE_WIDTH=320

if [ -z "$PRINTER_MAC" ]; then
	echo "Printer address is not registered."
	echo "Please run <source set_printer_mac.sh> first"
	exit 1
fi

sleep 1

echo "Capturing Image..."
python3 Image_Capture/camera.py "$IMAGE_FILENAME.jpg" >> /dev/null
echo "Capture Image Done..!"

echo "Processing Image..."
python3 Image_Processing/process.py "$IMAGE_FILENAME.jpg" "$IMAGE_FILENAME.bmp" $IMAGE_WIDTH $IMAGE_HEIGHT
echo "Process Image Done..!"

echo "Printing Image..."
bash Print_Scripts/print_bmp.sh "resources/frame_h_rev.bmp" 40 $IMAGE_WIDTH
sleep 0.1
bash Print_Scripts/print_bmp.sh "$IMAGE_FILENAME.bmp" $IMAGE_HEIGHT $IMAGE_WIDTH
sleep 0.1
bash Print_Scripts/print_bmp.sh "resources/frame_f_rev.bmp" 255 $IMAGE_WIDTH
sleep 0.1
bash Print_Scripts/print_feed.sh 6
echo "Print Image Done..!"
