from PIL import Image
import qrcode
import sys

def qr_gen(filename, qr_size):
	img_qr = qrcode.make(f"https://4cut.cecom.dev/download/{filename}")
	img_qr = img_qr.resize((qr_size, qr_size), Image.Resampling.LANCZOS)
	img_qr.save(f"{filename}.qr.bmp")

def main(argv):
	qr_gen(argv[1], int(argv[2]))

if __name__ == "__main__":
	main(sys.argv)
