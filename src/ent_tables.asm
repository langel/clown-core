ent_nothing_id           eqm $00
ent_clown_id             eqm $01
ent_seesaw_id            eqm $02


ent_spawn_lo:
	byte <do_nothing
	byte <ent_clown_spawn
	byte <ent_seesaw_spawn
ent_spawn_hi:
	byte >do_nothing
	byte >ent_clown_spawn
	byte >ent_seesaw_spawn

ent_update_lo:
	byte <do_nothing
	byte <ent_clown_update
	byte <ent_seesaw_update
ent_update_hi:
	byte >do_nothing
	byte >ent_clown_update
	byte >ent_seesaw_update
