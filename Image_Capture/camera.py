#!/usr/bin/python3
import time
from picamera2 import Picamera2, Preview

def capture_image():
    picam2 = Picamera2()
    picam2.start()
    time.sleep(2)

    picam2.capture_file("test.jpg")
    picam2.close()

if __name__ == "__main__":
    capture_image()
