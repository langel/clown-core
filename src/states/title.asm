
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

	jsr chr_load_game

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
