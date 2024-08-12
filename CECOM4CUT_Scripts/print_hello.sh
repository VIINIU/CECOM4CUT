#!/bin/sh

PRINT_HANDLE=0x2c

PRINT_STRING=$1
HEX_STRING=$(echo -n "$PRINT_STRING" | od -A n -t x1 | tr -d ' \n')

gatttool -b $PRINTER_MAC --char-write-req --handle=$PRINT_HANDLE --value=$HEX_STRING
gatttool -b $PRINTER_MAC --char-write-req --handle=$PRINT_HANDLE --value=0a
