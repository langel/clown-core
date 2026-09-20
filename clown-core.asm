
	processor 6502

	seg.u ZEROPAGE
	org $0000
	include "definitions.asm"
	include "zero_page.asm"

	seg HEADER
	org $7ff0
	; mapper, PRGs (16k), CHRs (8k), mirror, ram expansion
	;NES_HEADER 218, 2, 0, NES_MIRR_HORIZ, 0
	hex 4e 45 53 1a ; header
	byte 2 ; prg 16ks
	byte 0 ; chr 8ks
	byte $01|((218&$0f)<<$04)
	byte $da&$f0
	byte 0,0,0,0,0,0,0,0 ; reserved, set to zero

	seg CODE
	org $8000 
	include "vectors.asm"
	include "common.asm"
	include "common/arctan2.asm"

	include "chr_loader.asm"
	include "palette.asm"

	include "ent.asm"
	include "ent_tables.asm"
	include "ents/ball.asm"
	include "ents/laser.asm"

	include "state.asm"
	include "states/explore.asm"
	include "states/level_intro.asm"
	include "states/map.asm"
	include "states/title.asm"
	include "states/win.asm"

	org $e000 
chr_digits:
	incbin "assets/tileset.chr"


	;;;;; CPU VECTORS
	seg VECTORS
	org $fffa ; start at address $fffa
	.word nmi_handler	; $fffa vblank nmi
	.word cart_start	; $fffc reset
	.word nmi_handler	; $fffe irq / brk


