import RPi.GPIO as GPIO
import time

GPIO.setmode(GPIO.BCM)
GPIO.setup(25, GPIO.OUT)

for i in range(3):
	GPIO.output(25, GPIO.HIGH)
	time.sleep(0.5)
	GPIO.output(25, GPIO.LOW)
	time.sleep(0.5)
