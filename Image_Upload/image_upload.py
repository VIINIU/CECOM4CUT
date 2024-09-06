import base64
import requests
import sys

def upload_file(file_name):
	with open(file_name, "rb") as file:
		file_buffer = base64.b64encode(file.read()).decode("utf-8")

	upload_data = {
		"file": file_buffer,
		"filename": file_name.replace("result/", ""),
	}

	upload_url = "https://4cut.cecom.dev/upload"
	upload_header = {
		"Content-Type": "application/json"
	}

	upload_response = requests.post(upload_url, headers=upload_header, json=upload_data)
	print(upload_response)

def main(argv):
	if len(argv) != 2:
		print("usage: python3 image_upload.py <filename>")
		return

	upload_file(argv[1])

if __name__ == "__main__":
	main(sys.argv)
