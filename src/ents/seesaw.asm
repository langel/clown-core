
; DINGLE DANGLE

ent_seesaw_spawn: subroutine
	jsr ent_find_slot
	txa
	bmi .done
	lda #ent_seesaw_id
	sta ent_type,x
	; load baddie position
	lda temp06
	sta ent_x,x
	sta collision_0_x
	lda temp07
	sta ent_y,x
	sta collision_0_y

	lda #$78
	sta ent_x,x
	lda #$a0
	sta ent_y,x
.done
	rts


seesaw_pattern_table:
	hex 71 70 70 71 71 70 70 71
seesaw_attr_left_table:
	hex 00 00 80 80 80 80 00 00
seesaw_attr_right_table:
	hex c0 c0 40 40 40 40 c0 c0

ent_seesaw_update: subroutine


	;inc ent_x,x


ent_seesaw_render: subroutine


	; patterns
	; fulcrum
	lda #$ef
	sta spr_p,y
	; left side
	lda wtf
	shift_r 3
	and #$07
	sta temp00
	tax
	lda seesaw_pattern_table,x
	sta spr_p+4,y
	; right side
	sta spr_p+8,y

	; a
	lda #$00
	sta spr_a+0,y
	lda seesaw_attr_left_table,x
	sta spr_a+8,y
	lda seesaw_attr_right_table,x
	sta spr_a+4,y

	; x
	ldx ent_slot
	lda ent_x,x
	clc
	adc #$04
	sta spr_x+0,y
	lda ent_x,x
	sta spr_x+4,y
	lda ent_x,x
	clc
	adc #$08
	sta spr_x+8,y

	; y
	lda ent_y,x
	sta spr_y+0,y
	sta spr_y+4,y
	sta spr_y+8,y


	inc_y 12


	rts
	
	

