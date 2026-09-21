
/*
	; generate patterns
	lda #$25
	sta PPU_ADDR
	lda #$80
	sta PPU_ADDR
	ldx #$00
.char_loop
	stx PPU_DATA
	inx
	bne .char_loop
*/

chr_load_game: subroutine

	lda #$25
	sta PPU_ADDR
	lda #$80
	sta PPU_ADDR
	ldx #$00
.pattern_loop1
	lda chr_digits,x
	sta PPU_DATA
	inx
	bne .pattern_loop1
.pattern_loop2
	lda chr_digits+256,x
	sta PPU_DATA
	inx
	bne .pattern_loop2

	rts


chr_load_levelbox: subroutine
	bit PPU_STATUS
	lda #$24
	sta PPU_ADDR
	lda #$00
	sta PPU_ADDR
	ldx #$00
.levelbox_loop0
	lda chr_levelbox,x
	sta PPU_DATA
	inx
	bne .levelbox_loop0
.levelbox_loop1
	lda chr_levelbox+$100,x
	sta PPU_DATA
	inx
	bne .levelbox_loop1
.levelbox_loop2
	lda chr_levelbox+$200,x
	sta PPU_DATA
	inx
	bne .levelbox_loop2
.levelbox_loop3
	lda chr_levelbox+$300,x
	sta PPU_DATA
	inx
	bne .levelbox_loop3
	rts


chr_load_blocks: subroutine
	bit PPU_STATUS
	; block 0
	; is blank already
	; block 1
	lda #$27
	sta PPU_ADDR
	lda #$90
	sta PPU_ADDR
	ldx #$08
	ldy #$ff
.block1
	sty PPU_DATA
	dex
	bne .block1
	; block 2
	lda #$27
	sta PPU_ADDR
	lda #$a8
	sta PPU_ADDR
	ldx #$08
.block2
	sty PPU_DATA
	dex
	bne .block2
	; block 3
	ldx #$10
.block3
	sty PPU_DATA
	dex
	bne .block3
	rts	

