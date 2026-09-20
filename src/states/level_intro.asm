state_level_intro_init: subroutine
	STATE_SET state_level_intro_update

	jsr render_disable
	jsr main_palette_load
	jsr level_intro_draw_pattern
	jsr chr_load_game
	jsr chr_load_blocks
	jsr render_enable
	rts


state_level_intro_update: subroutine

	lda scroll_y
	clc
	adc #$03
	cmp #240
	bcc .scroll_good
	sec
	sbc #240
.scroll_good
	sta scroll_y
	rts


li_shuf          EQM $0300
li_metatiles     EQM $0310
li_attrbuf       EQM $0340
li_meta_y        EQM $0380
li_meta_x        EQM $0381
li_attr_base     EQM $0382
li_color_packed  EQM $0383
li_pal           EQM $0384
li_quad          EQM $0385
li_attr_bits     EQM $0386
li_shuf_index    EQM $0387
li_prev_last     EQM $0388
li_has_prev      EQM $0389
li_shuf_i        EQM $038a
li_shuf_div      EQM $038b
li_shuf_swap     EQM $038c


level_intro_draw_pattern: subroutine
	lda #$00
	sta PPU_CTRL

	ldx #$00
.clear_attr_loop
	sta li_attrbuf,x
	inx
	cpx #$40
	bne .clear_attr_loop

	sta li_shuf_index
	sta li_has_prev

	bit PPU_STATUS
	lda #$20
	sta PPU_ADDR
	lda #$00
	sta PPU_ADDR

	ldy #$00
.meta_row_loop
	sty li_meta_y

	tya
	lsr
	asl
	asl
	asl
	sta li_attr_base

	ldx #$00
.meta_cell_loop
	stx li_meta_x

	jsr level_intro_next_color
	sta li_color_packed

	and #$03
	clc
	adc #$f8
	ldx li_meta_x
	sta li_metatiles,x

	lda li_color_packed
	lsr
	lsr
	sta li_pal

	lda li_meta_y
	and #$01
	asl
	sta li_quad
	lda li_meta_x
	and #$01
	ora li_quad
	sta li_quad

	lda li_quad
	asl
	asl
	clc
	adc li_pal
	tax
	lda level_intro_attr_shift_table,x
	sta li_attr_bits

	ldx li_meta_x
	txa
	lsr
	clc
	adc li_attr_base
	tay
	lda li_attrbuf,y
	ora li_attr_bits
	sta li_attrbuf,y

	ldx li_meta_x
	inx
	cpx #$10
	bne .meta_cell_loop

	ldx #$00
.tile_top_row_loop
	lda li_metatiles,x
	sta PPU_DATA
	sta PPU_DATA
	inx
	cpx #$10
	bne .tile_top_row_loop

	ldx #$00
.tile_bottom_row_loop
	lda li_metatiles,x
	sta PPU_DATA
	sta PPU_DATA
	inx
	cpx #$10
	bne .tile_bottom_row_loop

	ldy li_meta_y
	iny
	cpy #$0f
	beq .meta_rows_done
	jmp .meta_row_loop

.meta_rows_done

	bit PPU_STATUS
	lda #$23
	sta PPU_ADDR
	lda #$c0
	sta PPU_ADDR
	ldx #$00
.attr_write_loop
	lda li_attrbuf,x
	sta PPU_DATA
	inx
	cpx #$40
	bne .attr_write_loop
	rts


level_intro_next_color: subroutine
	lda li_shuf_index
	bne .use_existing_shuffle
	jsr level_intro_shuffle_colors

.use_existing_shuffle
	ldx li_shuf_index
	lda li_shuf,x
	sta li_color_packed
	inx
	cpx #$09
	bne .store_shuffle_index

	ldx #$00
	lda li_color_packed
	sta li_prev_last
	lda #$01
	sta li_has_prev

.store_shuffle_index
	stx li_shuf_index
	lda li_color_packed
	rts


level_intro_shuffle_colors: subroutine
	ldx #$00
.copy_list_loop
	lda level_intro_color_list,x
	sta li_shuf,x
	inx
	cpx #$09
	bne .copy_list_loop

	ldx #$08
.shuffle_loop
	stx li_shuf_i

	jsr rng_update
	lda rng_val0

	ldy li_shuf_i
	iny
	sty li_shuf_div
.mod_loop
	cmp li_shuf_div
	bcc .mod_done
	sec
	sbc li_shuf_div
	bcs .mod_loop
.mod_done
	tay

	ldx li_shuf_i
	lda li_shuf,x
	sta li_shuf_swap
	lda li_shuf,y
	sta li_shuf,x
	lda li_shuf_swap
	sta li_shuf,y

	dex
	bpl .shuffle_loop

	lda li_has_prev
	beq .shuffle_done

	lda li_shuf
	cmp li_prev_last
	bne .shuffle_done

	ldy #$01
.find_nonmatching_loop
	lda li_shuf,y
	cmp li_prev_last
	bne .swap_first
	iny
	cpy #$09
	bne .find_nonmatching_loop
	jmp .shuffle_done

.swap_first
	lda li_shuf
	sta li_shuf_swap
	lda li_shuf,y
	sta li_shuf
	lda li_shuf_swap
	sta li_shuf,y

.shuffle_done
	rts


level_intro_color_list
	byte $05,$02,$01,$09,$0a,$0b,$0d,$0e,$0f

level_intro_attr_shift_table
	byte $00,$01,$02,$03
	byte $00,$04,$08,$0c
	byte $00,$10,$20,$30
	byte $00,$40,$80,$c0
