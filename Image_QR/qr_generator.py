from PIL import Image
import qrcode
import sys

def qr_gen(filename):
	img = qrcode.make(f"https://4cut.cecom.dev/download/{filename}")
	img.save(f"{filename}.qr.bmp")

def main(argv):
	qr_gen(argv[1])

if __name__ == "__main__":
	main(sys.argv)
