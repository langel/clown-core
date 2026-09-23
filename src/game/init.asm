
game_init: subroutine
	STATE_SET game_update

	jsr render_disable
	jsr sprites_clear
	jsr main_palette_load
	jsr chr_load_game

	jsr ent_clown_spawn
	jsr ent_clown_spawn
	jsr ent_seesaw_spawn
	
	jsr render_enable

	rts
