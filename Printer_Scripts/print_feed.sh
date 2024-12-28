#!/bin/sh

PRINT_HANDLE=0x2c

if [ $# -ne 1 ]; then
    echo "Error: Message Parameter is Needed"
    exit 1
fi

FEED_LINE=$1
for i in $(seq 1 $FEED_LINE); do
	gatttool -b $PRINTER_MAC --char-write-req --handle=$PRINT_HANDLE --value=0a
done
