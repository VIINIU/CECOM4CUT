from PIL import Image
import sys

def merge_image(photo_path, frame_header_path, frame_footer_path, qr_path, image_width, photo_height, frame_header_height, frame_footer_height):
	pass

def main(argv):
    if len(argv) != 9:
        print("usage: python3 merge.py <photo_filename> <frame_header_filename> <frame_footer_filename> <qr_filename> <image_width> <photo_height> <frame_header_height> <frame_footer_height>")
        return

    merge_image(argv[1], argv[2], argv[3], argv[4], int(argv[5]), int(argv[6]), int(argv[7]), int(argv[8]))


if __name__ == "__main__":
    main(sys.argv)
