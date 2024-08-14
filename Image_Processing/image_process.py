from PIL import Image

def convert_jpg_to_1bit_bmp(input_jpg_path, output_bmp_path):
	target_width = 320

	img = Image.open(input_jpg_path)
	img = img.convert('L')

	orig_width, orig_height = img.size
	target_height = int((target_width / orig_width) * orig_height)

	img = img.resize((target_width, target_height))
	img = img.point(lambda x: 0 if x < 128 else 255, '1')
	img.save(output_bmp_path, format='BMP')

input_jpg_path = 'input.jpg'
output_bmp_path = 'output.bmp'
convert_jpg_to_1bit_bmp(input_jpg_path, output_bmp_path)
