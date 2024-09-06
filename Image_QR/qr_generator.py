from PIL import Image
import qrcode
import sys

def qr_gen(filename):
	img_qr = qrcode.make(f"https://4cut.cecom.dev/download/{filename}")
	img_qr = img_qr.resize((100, 100), Image.Resampling.LANCZOS)
	img_bg = Image.new('RGB', (320, 100), 'white')
	img_bg.paste(img_qr, (0, 0))
	img_bg.save(f"{filename}.qr.bmp")

def main(argv):
	qr_gen(argv[1])

if __name__ == "__main__":
	main(sys.argv)
