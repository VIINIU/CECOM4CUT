#!/bin/bash
CURRENT_DATE=$(date +"%Y%m%d_%H%M%S")

IMAGE_FILENAME=$CURRENT_DATE
IMAGE_FRAME_HEADER_HEIGHT=85
IMAGE_FRAME_FOOTER_HEIGHT=707
IMAGE_PHOTO_HEIGHT=480

QR_SIZE=227

IMAGE_HEIGHT=$((IMAGE_PHOTO_HEIGHT + IMAGE_FRAME_HEADER_HEIGHT + IMAGE_FRAME_FOOTER_HEIGHT + 30))
IMAGE_WIDTH=640

IMAGE_RESULT_HEIGHT=$((IMAGE_HEIGHT / 2))
IMAGE_RESULT_WIDTH=$((IMAGE_WIDTH / 2))

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
python3 Image_QR/qr_generator.py "result/$IMAGE_FILENAME" $QR_SIZE
python3 Image_Processing/merge.py "result/$IMAGE_FILENAME.jpg" "result/$IMAGE_FILENAME.jpg" "resources/frame_header.jpg" "resources/frame_footer.jpg" "result/$IMAGE_FILENAME.qr.bmp" $IMAGE_HEIGHT $IMAGE_WIDTH $IMAGE_PHOTO_HEIGHT $IMAGE_FRAME_HEADER_HEIGHT $IMAGE_FRAME_FOOTER_HEIGHT $QR_SIZE
python3 Image_Processing/process.py "result/$IMAGE_FILENAME.jpg" "result/$IMAGE_FILENAME.bmp" $IMAGE_RESULT_WIDTH $IMAGE_RESULT_HEIGHT
echo "Process Image Done..!"

echo "Printing Image..."
bash Printer_Scripts/print_bmp.sh "result/$IMAGE_FILENAME.bmp" $IMAGE_HEIGHT $IMAGE_WIDTH
sleep 0.1
bash Printer_Scripts/print_feed.sh 5
echo "Print Image Done..!"

echo "Uploading Image..."
python3 Image_Upload/image_upload.py "result/$IMAGE_FILENAME.jpg"
echo "Upload Image Done..!"