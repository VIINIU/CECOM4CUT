#!/usr/bin/python3
from picamera2 import Picamera2, Preview
import sys
import time

def capture_image(filename):
    picam2 = Picamera2()
    picam2.start()
    time.sleep(2)

    picam2.capture_file(filename)
    picam2.close()

def main(argv):
    if len(argv) != 2:
        print("usage: python3 camera.py <filename>")
        return
    
    capture_image(argv[1])

if __name__ == "__main__":
    main(sys.argv)
