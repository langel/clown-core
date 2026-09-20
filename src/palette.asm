
main_palette:
	hex 0f 15 11 3d
	hex 0f 27 00 3d
	hex 0f 1b 24 28
	hex 0f 13 17 2c
	hex 0f 15 11 3d
	hex 0f 27 00 3d
	hex 0f 1b 24 28
	hex 0f 13 17 2c


main_palette_load:
	lda #$3f
	sta PPU_ADDR
	lda #$00
	sta PPU_ADDR
	ldx #$00
.pal_load_loop
	lda main_palette,x
	sta PPU_DATA
	inx
	cpx #$20
	bne .pal_load_loop
	rts
