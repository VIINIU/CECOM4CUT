#!/bin/bash

PRINT_HANDLE=0x2c

if [ $# -ne 3 ]; then
    echo "Error: Message Parameter is Needed"
    exit 1
fi

PRINT_FILE_NAME=$1
IMG_HEIGHT=$2
IMG_WIDTH=$3

ucTemp0="1d"
ucTemp1=$(printf "%x" "'v")
ucTemp2=$(printf "%x" "'0")
ucTemp3=$(printf "%x" "'0")
ucTemp4=$(printf "%02x" $(((IMG_WIDTH + 7) >> 3)))
ucTemp5="00"
ucTemp6=$(printf "%02x" $IMG_HEIGHT)
ucTemp7=$(printf "%02x" $((IMG_HEIGHT >> 8)))
BMP_PREFIX="$ucTemp0$ucTemp1$ucTemp2$ucTemp3$ucTemp4$ucTemp5$ucTemp6$ucTemp7"

gatttool -b $PRINTER_MAC --char-write-req --handle=$PRINT_HANDLE --value=$BMP_PREFIX
#gatttool -b $PRINTER_MAC --char-write-req --handle=$PRINT_HANDLE --value=00000000000000000000
gatttool -b $PRINTER_MAC --char-write-req --handle=$PRINT_HANDLE --value=000000000000000000000000000000000000

HEX_FILE_DATA=$(xxd -p "$PRINT_FILE_NAME" | tr -d '\n')
HEX_FILE_LEN=${#HEX_FILE_DATA}

PRINT_BUFFER_SIZE=$(printf "%d" $(( (IMG_WIDTH + 7) >> 3 )))
for (( i=0; i<$HEX_FILE_LEN; i+=$PRINT_BUFFER_SIZE )); do
    TMP_DATA=${HEX_FILE_DATA:i:PRINT_BUFFER_SIZE}
    TMP_DATA_LEN=${#TMP_DATA}

    for (( j=0; j<$TMP_DATA_LEN; j+=40 )); do
        if (( j + 40 > TMP_DATA_LEN )); then
            PRINT_BUFFER=${TMP_DATA:j}
        else
            PRINT_BUFFER=${TMP_DATA:j:40}
        fi
        gatttool -b $PRINTER_MAC --char-write-req --handle=$PRINT_HANDLE --value=$PRINT_BUFFER > /dev/null
    done
done

