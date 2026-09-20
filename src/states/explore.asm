

state_explore_init: subroutine
	STATE_SET state_explore_update

	jsr render_disable
	jsr main_palette_load



	jsr render_enable

	rts


state_explore_update: subroutine
	rts
