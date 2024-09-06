#!/bin/bash
CURRENT_DATE=$(date +"%Y%m%d_%H%M%S")

IMAGE_FILENAME=$CURRENT_DATE
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

echo "Capturing Image..."
python3 GPIO_Manager/gpio_camera_led.py
python3 Image_Capture/camera.py "result/$IMAGE_FILENAME.jpg"
echo "Capture Image Done..!"

echo "Processing Image..."
python3 Image_Processing/process.py "result/$IMAGE_FILENAME.jpg" "result/$IMAGE_FILENAME.bmp" $IMAGE_WIDTH $IMAGE_HEIGHT
python3 Image_QR/qr_generator.py "result/$IMAGE_FILENAME"
python3 Image_Processing/process.py "result/$IMAGE_FILENAME.qr.bmp" "result/$IMAGE_FILENAME.qr.bmp" $QR_WIDTH $QR_HEIGHT
echo "Process Image Done..!"

echo "Printing Image..."
bash Print_Scripts/print_bmp.sh "resources/frame_h_rev.bmp" 40 $IMAGE_WIDTH
bash Print_Scripts/print_bmp.sh "result/$IMAGE_FILENAME.bmp" $((IMAGE_HEIGHT + 5)) $IMAGE_WIDTH
bash Print_Scripts/print_bmp.sh "resources/frame_f_rev.bmp" 255 $IMAGE_WIDTH
bash Print_Scripts/print_bmp.sh "result/$IMAGE_FILENAME.qr.bmp" $((QR_HEIGHT + 5)) $QR_WIDTH
sleep 0.1
bash Print_Scripts/print_feed.sh 5
echo "Print Image Done..!"

echo "Uploading Image..."
python3 Image_Upload/image_upload.py "result/$IMAGE_FILENAME.jpg"
echo "Upload Image Done..!"
