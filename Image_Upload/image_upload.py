import sys

def upload_file(filename):
	print("Upload {filename}")

def main(argv):
	if len(argv) != 2:
		print("usage: python3 image_upload.py <filename>")
		return

	upload_file(argv[1])

if __name__ == "__main__":
	main(sys.argv)
