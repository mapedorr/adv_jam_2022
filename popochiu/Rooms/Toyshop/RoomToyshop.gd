tool
extends PopochiuRoom

const COLOR_BURN := Color('96485b')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
# TODO: Overwrite Godot's methods


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# What happens when Popochiu loads the room. At this point the room is in the
# tree but it is not visible
func on_room_entered() -> void:
	if C.player.last_room == 'LightRoom':
		C.player.position = get_point('LightRoom')
	else:
		C.player.position = get_point('Entrance')
	
	if Globals.playable_popochius.has('Gonorrein'):
		remove_character(C.get_character('Gonorrein'))


# What happens when the room changing transition finishes. At this point the room
# is visible.
func on_room_transition_finished() -> void:
	if not Globals.playable_popochius.has('Gonorrein')\
	and not Globals.state.SAW_GONORREIN:
		Globals.state.SAW_GONORREIN = true
		
		yield(E.run([
			C.player.face_left(),
			'Player: Oh! There is Gonorreín!',
			'Player: Playing in the arcade... as usual.'
		]), 'completed')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PUBLIC ░░░░
# You could put public functions here


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PRIVATE ░░░░
# You could put private functions here
