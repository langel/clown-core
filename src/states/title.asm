
state_title_palette:
	hex 0f 01 22 35
	hex 0f 01 22 35
	hex 0f 01 22 35
	hex 0f 01 22 35
	hex 0f 01 22 35
	hex 0f 01 22 35
	hex 0f 01 22 35
	hex 0f 01 22 35



state_title_init: subroutine
	STATE_SET state_title_update

	jsr render_disable

	jsr main_palette_load

	lda #$7f
	sta temp00
	lda #$00
	sta temp01
	lda #$20
	jsr nametable_fill
	lda #$7f
	sta temp00
	lda #$00
	sta temp01
	lda #$24
	jsr nametable_fill

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

	jsr render_enable

	lda #$00
	sta temp05
	lda #$20
	sta temp06
	jsr ent_ball_spawn

	rts

state_title_update: subroutine
	lda controls_d
	beq .do_nothing
	jsr state_explore_init
.do_nothing

	jsr ents_update

	rts
