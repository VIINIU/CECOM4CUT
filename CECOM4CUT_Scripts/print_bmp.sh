#!/bin/bash

PRINT_HANDLE=0x2c

if [ $# -ne 1 ]; then
    echo "Error: Message Parameter is Needed"
    exit 1
fi

IMG_HEIGHT=100
IMG_WIDTH=200

ucTemp0="1d"
ucTemp1=$(printf "%x" "'v")
ucTemp2=$(printf "%x" "'0")
ucTemp3=$(printf "%x" "'0")
ucTemp4=$(printf "%02x" $(((IMG_WIDTH + 7) >> 3)))
ucTemp5="00"
ucTemp6=$(printf "%02x" $IMG_HEIGHT)
ucTemp7=$(printf "%02x" $((IMG_HEIGHT >> 8)))
BMP_HEADER="$ucTemp0$ucTemp1$ucTemp2$ucTemp3$ucTemp4$ucTemp5$ucTemp6$ucTemp7"

gatttool -b $PRINTER_MAC --char-write-req --handle=$PRINT_HANDLE --value=$BMP_HEADER

PRINT_FILE_NAME=$1
HEX_FILE_DATA=$(xxd -p -c 256 "$PRINT_FILE_NAME" | tr -d '\n')

HEX_FILE_LEN=${#HEX_FILE_DATA}
GATT_CHUNK_SIZE=250

for (( i=0; i<$HEX_FILE_LEN; i+=$GATT_CHUNK_SIZE )); do
	TMP_SEND_DATA=${HEX_FILE_DATA:i:GATT_CHUNK_SIZE}
	gatttool -b $PRINTER_MAC --char-write-req --handle=$PRINT_HANDLE --value=$TMP_SEND_DATA
	sleep 1
done

gatttool -b $PRINTER_MAC --char-write-req --handle=$PRINT_HANDLE --value=0a0a0a0a0a
