#!/bin/bash
echo compiling && dasm clown-core.asm -Isrc -Iaudio -Ivisual -oclown-core.nes -f3 -v2 -llisting.txt
# dasm -sromsym.txt will export symbol file
