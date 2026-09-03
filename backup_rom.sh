#!/bin/bash

count=$(ls -1q exports/ | wc -l)
padding_length=4
padded_count=$(printf "%0${padding_length}d" "$count")
backup="clown-core__$padded_count.nes"	
	
echo $backup
cp clown-core.nes exports/$backup
