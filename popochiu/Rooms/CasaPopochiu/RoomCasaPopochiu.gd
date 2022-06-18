tool
extends PopochiuRoom
# warning-ignore-all:return_value_discarded

const COLOR_BURN := Color('BD6868')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
# TODO: Overwrite Godot's methods


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# What happens when Popochiu loads the room. At this point the room is in the
# tree but it is not visible
func on_room_entered() -> void:
	if C.player.last_room == 'Map':
		C.player.position = get_point('Entrance')
	
	if Globals.playable_popochius.has('Goddiu')\
	and C.player.script_name != 'Goddiu':
		remove_character(C.get_character('Goddiu'))
	
	if Globals.playable_popochius.has('Popsy')\
	and C.player.script_name != 'Popsy':
		remove_character(C.get_character('Popsy'))
	
	if Globals.playable_popochius.has('Trapusinsiu')\
	and C.player.script_name != 'Trapusinsiu':
		remove_character(C.get_character('Trapusinsiu'))
	
	if Globals.state.CHIQUINININ_FREED\
	and not Globals.found_pages[Globals.PageCodes.CREDITS]:
		place_popochius()


# What happens when the room changing transition finishes. At this point the room
# is visible.
func on_room_transition_finished() -> void:
	if visited_first_time and not I.is_item_in_inventory('Book'):
		Globals.connect('book_closed', self, '_cry_again')
		
		yield(E.run_cutscene([
			'Goddiu(sad): Dabu dabudabu dabu!',
			'Popsy(sad): Bah bahbahbah bah!',
			'Trapusinsiu(sad): Hmmmm hmhmhm hmm hmmmm!',
		]), 'completed')
	elif Globals.state.CHIQUINININ_FREED\
	and not Globals.found_pages[Globals.PageCodes.CREDITS]:
		yield(E.run_cutscene([
			'Goddiu: Thanks for helping us find Chiquininín.',
			'Gonorrein: ' + Utils.say_in_popochiu(
				'Popsy washed him and now he smells like a Popochiu chiquitíu.',
				'baby'
			),
			"Trapusinsiu: We will keep Marcianiu's knife to defend ourselves against the Robertos.",
			"Popsy: It's a pity I can't give you an ice cream.",
			"Popsy: Because we're in different worlds...",
			'Goddiu: Chiquininín, you should say thank you.',
			'Chiquininin(happy): Thank you so much invisible one!!!',
			'Chiquininin: I found this in the place where Roberto locked me up.',
			"Chiquininin: I think it's from that book you carry.",
		]), 'completed')
		
		Globals.found_pages[Globals.PageCodes.CREDITS] = true
		Globals.show_book(Globals.PageCodes.CREDITS)
		yield(Globals, 'book_closed')
		
		yield(E.run_cutscene([
			'Goddiu(happy): iiiiii!!!!',
			'Popsy(happy): iiiiii!!!!',
			'Trapusinsiu(happy): iiiiii!!!!',
			'Gonorrein(happy): iiiiii!!!!',
			'Chiquininin(happy): iiiiii!!!!',
			'...',
			'Chiquininin: Now what?',
			"Gonorrein: I don't know.",
			"Goddiu: I'm hungry.",
			"Trapusinsiu: Me too.",
			"Popsy: I wonder what will be our next adventure.",
			"Gonorrein: Mine will be in the Toyshop... I have a game to finish.",
		]), 'completed')
		
		for c in $Characters.get_children():
			if c.script_name == 'Trapusinsiu': continue
			c.can_move = true


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PUBLIC ░░░░
func place_popochius() -> void:
	C.player.can_move = false
	
	for c in C.characters:
		if not get_point(c.script_name):
			continue
		
		c.can_move = false
		c.position = get_point(c.script_name)
		
		if c.script_name != C.player.script_name:
			add_character(c)
	
	C.get_character('Goddiu').face_right(false)
	C.get_character('Trapusinsiu').face_right(false)
	C.get_character('Popsy').face_left(false)
	C.get_character('Gonorrein').face_left(false)
	Globals.packed_popochius.clear()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PRIVATE ░░░░
func _cry_again() -> void:
	if Globals.read_pages.has(Globals.PageCodes.GODDIU_CHIQUINININ):
		Globals.disconnect('book_closed', self, '_cry_again')
		
		yield(E.run_cutscene([
			'Goddiu: ' + Utils.say_in_popochiu('ay doooooooooooo', 'cries'),
			'Popsy: Bah bahbahbah!!!',
			'Trapusinsiu: Hmm hmmmhmmm hm hm hm hm!!!',
		]), 'completed')
