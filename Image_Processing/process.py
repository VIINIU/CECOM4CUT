from PIL import Image
import sys

def convert_jpg_to_1bit_bmp(input_jpg_path, output_bmp_path, target_width, target_height):
	img = Image.open(input_jpg_path)
	img = img.resize((target_width, target_height))

	img_bg = Image.new("RGB", (target_width, target_height + 5), "white")
	img_bg.paste(img, (0, 0))
	img_bg = img_bg.convert("1", dither=Image.FLOYDSTEINBERG)
	img_bg = img_bg.point(lambda x: 255 if x < 128 else 0, "1")
	img_bg = img_bg.transpose(Image.FLIP_TOP_BOTTOM)
	img_bg.save(output_bmp_path, format="BMP")

def main(argv):
    if len(argv) != 5:
        print("usage: python3 process.py <original_jpg_filename> <result_bmp_filename> <result_width> <result_height>")
        return

    convert_jpg_to_1bit_bmp(argv[1], argv[2], int(argv[3]), int(argv[4]))


if __name__ == "__main__":
    main(sys.argv)
