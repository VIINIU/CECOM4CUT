#!/bin/bash
CURRENT_DATE=$(date +"%Y%m%d_%H%M%S")

IMAGE_FILENAME=$CURRENT_DATE
IMAGE_FRAME_HEADER_HEIGHT=35
IMAGE_FRAME_FOOTER_HEIGHT=250
IMAGE_PHOTO_HEIGHT=240
IMAGE_WIDTH=320

QR_SIZE=100

if [ -z "$PRINTER_MAC" ]; then
	echo "Printer address is not registered."
	echo "Please run <source set_printer_mac.sh> first"
	exit 1
fi

sleep 1

echo "Capturing Image..."
python3 GPIO_Manager/gpio_led_camera_ready.py
python3 Image_Capture/camera.py "result/$IMAGE_FILENAME.jpg"
python3 GPIO_Manager/gpio_led_camera_done.py
echo "Capture Image Done..!"

echo "Processing Image..."
python3 Image_Processing/process.py "result/$IMAGE_FILENAME.jpg" "result/$IMAGE_FILENAME.bmp" $IMAGE_WIDTH $IMAGE_PHOTO_HEIGHT
python3 Image_QR/qr_generator.py "result/$IMAGE_FILENAME"
python3 Image_Processing/process.py "result/$IMAGE_FILENAME.qr.bmp" "result/$IMAGE_FILENAME.qr.bmp" $IMAGE_WIDTH $QR_SIZE
echo "Process Image Done..!"

echo "Printing Image..."
bash Printer_Scripts/print_bmp.sh "resources/frame_h_rev.bmp" $((IMAGE_FRAME_HEADER_HEIGHT + 5)) $IMAGE_WIDTH
bash Printer_Scripts/print_bmp.sh "result/$IMAGE_FILENAME.bmp" $((IMAGE_PHOTO_HEIGHT + 5)) $IMAGE_WIDTH
bash Printer_Scripts/print_bmp.sh "resources/frame_f_rev.bmp" $((IMAGE_FRAME_FOOTER_HEIGHT + 5)) $IMAGE_WIDTH
bash Printer_Scripts/print_bmp.sh "result/$IMAGE_FILENAME.qr.bmp" $((QR_HEIGHT + 5)) $IMAGE_WIDTH
sleep 0.1
bash Printer_Scripts/print_feed.sh 5
echo "Print Image Done..!"

echo "Uploading Image..."
python3 Image_Upload/image_upload.py "result/$IMAGE_FILENAME.jpg"
echo "Upload Image Done..!"
