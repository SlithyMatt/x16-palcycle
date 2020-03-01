#!/bin/bash

gcc -o asc2bin.exe asc2bin.c
gcc -o make4bitbin.exe make4bitbin.c
./make4bitbin.exe x16_butterfly.data BITMAP.BIN
./asc2bin.exe pal.hex PAL.BIN
cl65 --cpu 65C02 -o PALCYCLE.PRG -l palcycle.list palcycle.asm
