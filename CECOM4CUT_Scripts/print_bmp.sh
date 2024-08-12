#!/bin/sh

PRINT_HANDLE=0x2c

if [ $# -ne 1 ]; then
    echo "Error: Message Parameter is Needed"
    exit 1
fi

PRINT_FILE_NAME=$1

gatttool -b $PRINTER_MAC --char-write-req --handle=$PRINT_HANDLE --value=0a0a0a0a0a
