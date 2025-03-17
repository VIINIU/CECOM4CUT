from PIL import Image
import sys

def merge_image(result_path, photo_path, frame_header_path, frame_footer_path, qr_path, image_height, image_width, photo_height, frame_header_height, frame_footer_height, qr_size):
	img_photo = Image.open(photo_path)
	img_photo = img_photo.resize((image_width, image_width // 4 * 3))

	img_frame_header = Image.open(frame_header_path)
	img_frame_footer = Image.open(frame_footer_path)
	img_qr = Image.open(qr_path)

	img_res = Image.new("RGB", (image_width, image_height), "white")
	img_res.paste(img_frame_header, (0, 0))
	img_res.paste(img_photo, (0, frame_header_height))
	img_res.paste(img_frame_footer, (0, frame_header_height + photo_height))
	img_res.paste(img_qr, (357, image_height - qr_size - 90))

	img_res.save(result_path, format="JPEG")

def main(argv):
    if len(argv) != 12:
        print("usage: python3 merge.py <result_filename> <photo_filename> <frame_header_filename> <frame_footer_filename> <qr_filename> <image_height> <image_width> <photo_height> <frame_header_height> <frame_footer_height> <qr_size>")
        return

    merge_image(argv[1], argv[2], argv[3], argv[4], argv[5], int(argv[6]), int(argv[7]), int(argv[8]), int(argv[9]), int(argv[10]), int(argv[11]))


if __name__ == "__main__":
    main(sys.argv)
