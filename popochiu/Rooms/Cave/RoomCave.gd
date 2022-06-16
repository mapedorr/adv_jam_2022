tool
extends PopochiuRoom

const COLOR_BURN := Color('aae0f3')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
# TODO: Overwrite Godot's methods


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# What happens when Popochiu loads the room. At this point the room is in the
# tree but it is not visible
func on_room_entered() -> void:
	C.player.position = get_hotspot('Exit').position
	
	put_marcianiu_on_top()
	C.get_character('Marcianiu').disable(false)
	
	if Globals.state.SYMBOL_ACTIVATED:
		C.get_character('Marcianiu').enable(false)
		C.character_walk_to('Marcianiu', get_point('HideoutEntrance'), false)


# What happens when the room changing transition finishes. At this point the room
# is visible.
func on_room_transition_finished() -> void:
	yield(E.run([]), 'completed')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PUBLIC ░░░░
func put_marcianiu_on_top() -> void:
	$Characters.move_child(
		C.get_character('Marcianiu'), $Characters.get_child_count()
	)


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PRIVATE ░░░░
# You could put private functions here
