from PIL import Image
import sys

def convert_jpg_to_1bit_bmp(input_jpg_path, output_bmp_path, target_width):
	img = Image.open(input_jpg_path)
	img = img.convert('1')

	orig_width, orig_height = img.size
	target_height = int((target_width / orig_width) * orig_height)

	img = img.resize((target_width, target_height))
	img = img.point(lambda x: 255 if x < 128 else 0, '1')
	img.save(output_bmp_path, format='BMP')

def main(argv):
    if len(argv) != 4:
        print("usage: python3 process.py <original_jpg_filename> <result_bmp_filename> <result_width>")
        return

    convert_jpg_to_1bit_bmp(argv[1], argv[2], int(argv[3]))


if __name__ == "__main__":
    main(sys.argv)
