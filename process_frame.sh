#!/bin/sh
echo "Processing Frames..."
python3 Image_Processing/process.py "resources/frame_h.jpg" "resources/frame_h_rev.bmp" 320 40
python3 Image_Processing/process.py "resources/frame_f.jpg" "resources/frame_f_rev.bmp" 320 255
echo "Process Frames Done..!"
