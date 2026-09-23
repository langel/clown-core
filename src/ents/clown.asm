
ent_clown_spawn: subroutine
	jsr ent_find_slot
	txa
	bmi .done
	lda #ent_clown_id
	sta ent_type,x
	; load clown pos
	txa
	and #$01
	bne .right_clown
.left_clown
	lda #$40
	jmp .set_x
.right_clown
	lda #$bc
.set_x
	sta ent_x,x
	lda #$70
	sta ent_y,x
.done
	rts


ent_clown_update: subroutine

	inc ent_r0,x
	
	ent_move_by_velocity

	ldy ent_spr_ptr
ent_clown_render: subroutine

	; p
	lda wtf
	shift_r 3
	and #$03
	clc
	adc #$e2
	sta spr_p+0,y
	adc #$10
	sta spr_p+4,y
	; a
	lda #$00
	sta spr_a+0,y
	sta spr_a+4,y
	; x
	lda ent_x,x
	sta spr_x+0,y
	sta spr_x+4,y
	; y
	lda ent_y,x
	sta spr_y+0,y
	clc
	adc #$08
	sta spr_y+4,y

	inc_y 8

	rts
