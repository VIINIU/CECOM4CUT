#!/bin/bash

PRINT_HANDLE=0x2c

if [ $# -ne 1 ]; then
    echo "Error: Message Parameter is Needed"
    exit 1
fi

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
