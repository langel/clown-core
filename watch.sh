#!/bin/bash
onchange -v -p 250 './**/*.asm' -- sh -c 'echo compiling && dasm clown-core.asm -Isrc -Iassets -oclown-core.nes -f3 -v2 -llisting.txt && echo launching && cmd.exe /C start clown-core.nes'
# dasm -sromsym.txt will export symbol file
# https://www.npmjs.com/package/onchange
